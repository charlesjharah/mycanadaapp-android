#!/bin/bash
set -e

echo "Updating layouts for BOLDER text..."

# 1. Update the Onboarding Page Layout (The Slide)
# Changes: Title 28sp -> 32sp (Black), Description 16sp -> 18sp (Darker Gray)
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
        android:layout_height="350dp"
        android:src="@drawable/img_intro_1"
        android:scaleType="centerCrop"
        android:layout_marginBottom="30dp"/>

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:paddingHorizontal="24dp"
        android:gravity="center">

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
            android:layout_marginBottom="16dp"/>

        <TextView
            android:id="@+id/textDescription"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Description goes here."
            android:textSize="18sp"
            android:textStyle="normal"
            android:fontFamily="@font/montserrat_regular"
            android:textColor="#334155"
            android:textAlignment="center"
            android:lineSpacingExtra="6dp"/>
    </LinearLayout>
</LinearLayout>
EOF

# 2. Update the Splash Activity (The Button)
# Changes: Button Text 18sp -> 20sp (BOLD)
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

echo "DONE! Text is now BOLD and beautiful."