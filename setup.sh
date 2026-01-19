#!/bin/bash
set -e

# 1. Create Directories
echo "Creating directories..."
mkdir -p app/src/main/java/com/mycanada/app
mkdir -p app/src/main/res/drawable
mkdir -p app/src/main/res/font
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/xml

# --- ASSET DOWNLOADS ---

# 2. Download Beautiful Images (Unsplash)
echo "Downloading high-quality images..."
# Intro 1: Canada landscape (Welcome)
curl -L "https://images.unsplash.com/photo-1517935706615-2717063c2225?q=80&w=800&h=600&fit=crop" -o app/src/main/res/drawable/img_intro_1.png
# Intro 2: Growth/Benefits (Plant & Money)
curl -L "https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?q=80&w=800&h=600&fit=crop" -o app/src/main/res/drawable/img_intro_2.png
# Intro 3: Security (Digital Lock)
curl -L "https://images.unsplash.com/photo-1555949963-aa79dcee981c?q=80&w=800&h=600&fit=crop" -o app/src/main/res/drawable/img_intro_3.png

# 3. Download Custom Fonts (Montserrat)
echo "Downloading custom fonts..."
# Using GitHub raw links for reliable font downloads
curl -L "https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Bold.ttf" -o app/src/main/res/font/montserrat_bold.ttf
curl -L "https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Regular.ttf" -o app/src/main/res/font/montserrat_regular.ttf

# --- UI DEFINITIONS ---

# 4. Create Custom Rounded Gradient Button Background
echo "Creating custom button style..."
cat <<EOF > app/src/main/res/drawable/bg_button_gradient.xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
    <gradient
        android:startColor="#D80000"
        android:endColor="#B00000"
        android:angle="270"/>
    <corners android:radius="25dp"/>
</shape>
EOF

# 5. Write: item_onboarding_page.xml (With new Fonts and Image adjust)
echo "Writing beautiful layouts..."
cat <<EOF > app/src/main/res/layout/item_onboarding_page.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center_horizontal"
    android:background="#FFFFFF">

    <ImageView
        android:id="@+id/imgOnboarding"
        android:layout_width="match_parent"
        android:layout_height="320dp"
        android:src="@drawable/img_intro_1"
        android:scaleType="centerCrop"
        android:layout_marginBottom="40dp"/>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:paddingHorizontal="32dp"
        android:gravity="center">

        <TextView
            android:id="@+id/textTitle"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Welcome"
            android:textSize="28sp"
            android:fontFamily="@font/montserrat_bold"
            android:textColor="#1e293b"
            android:textAlignment="center"
            android:layout_marginBottom="16dp"/>

        <TextView
            android:id="@+id/textDescription"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Description goes here."
            android:textSize="16sp"
            android:fontFamily="@font/montserrat_regular"
            android:textColor="#64748b"
            android:textAlignment="center"
            android:lineSpacingExtra="4dp"/>
    </LinearLayout>
</LinearLayout>
EOF

# 6. Write: activity_splash.xml (With Custom Button)
cat <<EOF > app/src/main/res/layout/activity_splash.xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#FFFFFF">

    <androidx.viewpager2.widget.ViewPager2
        android:id="@+id/viewPager"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintBottom_toTopOf="@id/btnContainer" />

    <FrameLayout
        android:id="@+id/btnContainer"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        app:layout_constraintBottom_toBottomOf="parent"
        android:padding="24dp">
        
        <androidx.appcompat.widget.AppCompatButton
            android:id="@+id/btnNext"
            android:layout_width="match_parent"
            android:layout_height="55dp"
            android:text="Next"
            android:background="@drawable/bg_button_gradient"
            android:textColor="#FFFFFF"
            android:textSize="18sp"
            android:fontFamily="@font/montserrat_bold"
            android:textAllCaps="false"
            android:stateListAnimator="@null" />
    </FrameLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
EOF

# --- KOTLIN LOGIC ---

# 7. Write: OnboardingAdapter.kt (Same logic)
echo "Writing Kotlin files..."
cat <<EOF > app/src/main/java/com/mycanada/app/OnboardingAdapter.kt
package com.mycanada.app

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class OnboardingAdapter(
    private val titles: List<String>, 
    private val descs: List<String>, 
    private val images: List<Int>
) : RecyclerView.Adapter<OnboardingAdapter.OnboardingViewHolder>() {

    inner class OnboardingViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val image: ImageView = view.findViewById(R.id.imgOnboarding)
        val title: TextView = view.findViewById(R.id.textTitle)
        val desc: TextView = view.findViewById(R.id.textDescription)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): OnboardingViewHolder {
        return OnboardingViewHolder(
            LayoutInflater.from(parent.context).inflate(R.layout.item_onboarding_page, parent, false)
        )
    }

    override fun onBindViewHolder(holder: OnboardingViewHolder, position: Int) {
        holder.title.text = titles[position]
        holder.desc.text = descs[position]
        holder.image.setImageResource(images[position])
    }

    override fun getItemCount(): Int = titles.size
}
EOF

# 8. Write: SplashActivity.kt (Same logic, slightly updated texts)
cat <<EOF > app/src/main/java/com/mycanada/app/SplashActivity.kt
package com.mycanada.app

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager2.widget.ViewPager2

class SplashActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val viewPager = findViewById<ViewPager2>(R.id.viewPager)
        val btnNext = findViewById<Button>(R.id.btnNext)

        val titles = listOf("Welcome to MyCanada", "Maximize Your Benefits", "Secure & Private")
        val descs = listOf(
            "Your personal gateway to government benefits, managed simply and effectively.",
            "Our smart logic automatically finds every program you are eligible for.",
            "Your data is encrypted and stored locally on your device. We prioritize your privacy."
        )
        val images = listOf(R.drawable.img_intro_1, R.drawable.img_intro_2, R.drawable.img_intro_3)

        viewPager.adapter = OnboardingAdapter(titles, descs, images)

        btnNext.setOnClickListener {
            if (viewPager.currentItem < titles.size - 1) {
                viewPager.currentItem += 1
            } else {
                startActivity(Intent(this, MainActivity::class.java))
                finish()
            }
        }
        
        viewPager.registerOnPageChangeCallback(object : ViewPager2.OnPageChangeCallback() {
            override fun onPageSelected(position: Int) {
                if (position == titles.size - 1) {
                    btnNext.text = "Get Started"
                } else {
                    btnNext.text = "Next"
                }
            }
        })
    }
}
EOF

# 9. Write: activity_main.xml (Spinner Layout)
cat <<EOF > app/src/main/res/layout/activity_main.xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <WebView
        android:id="@+id/webview"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:visibility="invisible" />

    <ProgressBar
        android:id="@+id/progressBar"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:indeterminateTint="#D80000"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
EOF

# 10. Write: MainActivity.kt (UPDATED URL HERE)
cat <<EOF > app/src/main/java/com/mycanada/app/MainActivity.kt
package com.mycanada.app

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.view.View
import android.webkit.*
import android.widget.ProgressBar
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date

class MainActivity : AppCompatActivity() {

    private lateinit var webView: WebView
    private lateinit var progressBar: ProgressBar
    private var fileUploadCallback: ValueCallback<Array<Uri>>? = null
    private var cameraImageUri: Uri? = null

    // *** UPDATED LIVE URL ***
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
        progressBar = findViewById(R.id.progressBar)
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
                // Keep user within the app domain
                if (url.contains("mycanadaapp.ca")) { 
                    return false
                }
                // Open external links (Banks, etc) in Chrome
                val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                startActivity(intent)
                return true
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                progressBar.visibility = View.GONE
                webView.visibility = View.VISIBLE
                super.onPageFinished(view, url)
            }
        }

        webView.webChromeClient = object : WebChromeClient() {
            override fun onShowFileChooser(webView: WebView?, filePathCallback: ValueCallback<Array<Uri>>?, fileChooserParams: FileChooserParams?): Boolean {
                if (fileUploadCallback != null) fileUploadCallback?.onReceiveValue(null)
                fileUploadCallback = filePathCallback

                var takePictureIntent: Intent? = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                if (takePictureIntent!!.resolveActivity(packageManager) != null) {
                    var photoFile: File? = null
                    try { photoFile = createImageFile() } catch (ex: IOException) {}
                    if (photoFile != null) {
                        cameraImageUri = FileProvider.getUriForFile(this@MainActivity, "com.mycanada.app.provider", photoFile)
                        takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, cameraImageUri)
                    } else { takePictureIntent = null }
                }
                val contentSelectionIntent = Intent(Intent.ACTION_GET_CONTENT).apply {
                    addCategory(Intent.CATEGORY_OPENABLE)
                    type = "*/*"
                }
                val intentArray: Array<Intent?> = if (takePictureIntent != null) arrayOf(takePictureIntent) else arrayOfNulls(0)
                val chooserIntent = Intent(Intent.ACTION_CHOOSER).apply {
                    putExtra(Intent.EXTRA_INTENT, contentSelectionIntent)
                    putExtra(Intent.EXTRA_TITLE, "Upload or Take Photo")
                    putExtra(Intent.EXTRA_INITIAL_INTENTS, intentArray)
                }
                fileSelectionLauncher.launch(chooserIntent)
                return true
            }
            override fun onPermissionRequest(request: PermissionRequest) { request.grant(request.resources) }
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
EOF

# 11. Write: AndroidManifest.xml (Keep Splash as launcher)
echo "Updating Manifest..."
cat <<EOF > app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="MyCanada"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat.Light.NoActionBar">
        
        <provider
            android:name="androidx.core.content.FileProvider"
            android:authorities="com.mycanada.app.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/file_paths" />
        </provider>

        <activity
            android:name=".SplashActivity"
            android:exported="true"
            android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity android:name=".MainActivity" android:exported="false" />
    </application>
</manifest>
EOF

echo "DONE! UI Beautified and URL updated."