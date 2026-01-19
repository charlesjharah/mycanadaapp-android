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

        val titles = listOf("Welcome to MyCanada", "Maximize Benefits", "Secure & Private")
        val descs = listOf(
            "Access all your government benefits in one simple dashboard.",
            "Our smart logic finds every program you are eligible for.",
            "Your data is encrypted and stored locally on your device."
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
