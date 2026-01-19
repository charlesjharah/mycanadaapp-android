package com.mycanada.app

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.webkit.*
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private var fileUploadCallback: ValueCallback<Array<Uri>>? = null
    private var cameraImageUri: Uri? = null

    // *** CHANGE THIS URL TO YOUR LIVE PHP SITE ***
    private val TARGET_URL = "https://mycanadaapp.ca/api/index.php" 

    private val fileSelectionLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
        if (fileUploadCallback != null) {
            var results: Array<Uri>? = null
            if (result.resultCode == Activity.RESULT_OK) {
                if (result.data?.data != null) {
                    results = arrayOf(result.data!!.data!!)
                } else if (cameraImageUri != null) {
                    results = arrayOf(cameraImageUri!!)
                }
            }
            fileUploadCallback?.onReceiveValue(results)
            fileUploadCallback = null
        }
    }

    private val requestPermissionLauncher = registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
        if (permissions[Manifest.permission.CAMERA] == true) {
            webView.reload()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        webView = findViewById(R.id.webview)
        checkPermissions()

        val webSettings = webView.settings
        webSettings.javaScriptEnabled = true
        webSettings.domStorageEnabled = true
        webSettings.allowFileAccess = true
        webSettings.mediaPlaybackRequiresUserGesture = false
        webSettings.databaseEnabled = true

        webView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                val url = request?.url.toString()
                if (url.contains(TARGET_URL) || url.contains("mycanada")) { 
                    return false
                }
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                startActivity(intent)
                return true
            }
        }

        webView.webChromeClient = object : WebChromeClient() {
            override fun onShowFileChooser(webView: WebView?, filePathCallback: ValueCallback<Array<Uri>>?, fileChooserParams: FileChooserParams?): Boolean {
                if (fileUploadCallback != null) {
                    fileUploadCallback?.onReceiveValue(null)
                }
                fileUploadCallback = filePathCallback

                var takePictureIntent: Intent? = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                if (takePictureIntent!!.resolveActivity(packageManager) != null) {
                    var photoFile: File? = null
                    try {
                        photoFile = createImageFile()
                    } catch (ex: IOException) {}
                    
                    if (photoFile != null) {
                        cameraImageUri = FileProvider.getUriForFile(this@MainActivity, "com.mycanada.app.provider", photoFile)
                        takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, cameraImageUri)
                    } else {
                        takePictureIntent = null
                    }
                }

                val contentSelectionIntent = Intent(Intent.ACTION_GET_CONTENT)
                contentSelectionIntent.addCategory(Intent.CATEGORY_OPENABLE)
                contentSelectionIntent.type = "*/*"

                val intentArray: Array<Intent?> = if (takePictureIntent != null) arrayOf(takePictureIntent) else arrayOfNulls(0)
                val chooserIntent = Intent(Intent.ACTION_CHOOSER)
                chooserIntent.putExtra(Intent.EXTRA_INTENT, contentSelectionIntent)
                chooserIntent.putExtra(Intent.EXTRA_TITLE, "Upload or Take Photo")
                chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, intentArray)

                fileSelectionLauncher.launch(chooserIntent)
                return true
            }
            override fun onPermissionRequest(request: PermissionRequest) {
                request.grant(request.resources)
            }
        }
        webView.loadUrl(TARGET_URL)
    }

    @Throws(IOException::class)
    private fun createImageFile(): File {
        val timeStamp: String = SimpleDateFormat("yyyyMMdd_HHmmss").format(Date())
        val storageDir: File? = getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        return File.createTempFile("JPEG_${timeStamp}_", ".jpg", storageDir)
    }

    private fun checkPermissions() {
        val permissions = mutableListOf(Manifest.permission.CAMERA, Manifest.permission.INTERNET)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            permissions.add(Manifest.permission.READ_MEDIA_IMAGES)
        } else {
            permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE)
        }
        requestPermissionLauncher.launch(permissions.toTypedArray())
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) webView.goBack() else super.onBackPressed()
    }
}