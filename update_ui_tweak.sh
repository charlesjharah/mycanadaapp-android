#!/bin/bash
set -e

echo "Adjusting layout: Taller images, text at bottom, new background..."

# 1. Update Onboarding Page (The Slide)
# - Background changed to #fdfdfd
# - ImageView now has layout_weight="1", so it stretches to fill the top space
# - Text container sits at the bottom
cat <<EOF > app/src/main/res/layout/item_onboarding_page.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="#fdfdfd">

    <ImageView
        android:id="@+id/imgOnboarding"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:src="@drawable/img_intro_1"
        android:scaleType="centerCrop" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:paddingHorizontal="24dp"
        android:paddingTop="32dp"
        android:paddingBottom="100dp"
        android:gravity="center_horizontal">

        <TextView
            android:id="@+id/textTitle"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Welcome"
            android:textSize="32sp"
            android:textStyle="bold"
            android:fontFamily="@font/montserrat_bold"
            android:textColor="#000000"
            android:textAlignment="center"
            android:layout_marginBottom="12dp"/>

        <TextView
            android:id="@+id/textDescription"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Description goes here."
            android:textSize="18sp"
            android:fontFamily="@font/montserrat_regular"
            android:textColor="#334155"
            android:textAlignment="center"
            android:lineSpacingExtra="4dp"/>
    </LinearLayout>
</LinearLayout>
EOF

# 2. Update Splash Activity (Container)
# - Background changed to #fdfdfd
cat <<EOF > app/src/main/res/layout/activity_splash.xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#fdfdfd">

    <androidx.viewpager2.widget.ViewPager2
        android:id="@+id/viewPager"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

    <FrameLayout
        android:id="@+id/btnContainer"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        app:layout_constraintBottom_toBottomOf="parent"
        android:padding="24dp">
        
        <androidx.appcompat.widget.AppCompatButton
            android:id="@+id/btnNext"
            android:layout_width="match_parent"
            android:layout_height="60dp"
            android:text="Next"
            android:background="@drawable/bg_button_gradient"
            android:textColor="#FFFFFF"
            android:textSize="20sp"
            android:textStyle="bold"
            android:fontFamily="@font/montserrat_bold"
            android:textAllCaps="false"
            android:stateListAnimator="@null" />
    </FrameLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
EOF

echo "DONE! Layout adjusted."