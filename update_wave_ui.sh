#!/bin/bash
set -e

echo "Creating Wavy Border UI..."

# 1. Create the Wave Vector Drawable
# This shape mimics a wave and will be colored #fdfdfd (Background color)
cat <<EOF > app/src/main/res/drawable/ic_wave_shape.xml
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="1440dp"
    android:height="320dp"
    android:viewportWidth="1440"
    android:viewportHeight="320">
    <path
        android:fillColor="#fdfdfd"
        android:pathData="M0,224L48,213.3C96,203,192,181,288,181.3C384,181,480,203,576,224C672,245,768,267,864,261.3C960,256,1056,224,1152,208C1248,192,1344,192,1392,192L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z" />
</vector>
EOF

# 2. Update the Layout to include the Wave
cat <<EOF > app/src/main/res/layout/item_onboarding_page.xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#fdfdfd">

    <ImageView
        android:id="@+id/imgOnboarding"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:src="@drawable/img_intro_1"
        android:scaleType="centerCrop"
        app:layout_constraintHeight_percent="0.6"
        app:layout_constraintTop_toTopOf="parent" />

    <ImageView
        android:layout_width="match_parent"
        android:layout_height="80dp"
        android:src="@drawable/ic_wave_shape"
        android:scaleType="fitXY"
        app:layout_constraintBottom_toBottomOf="@id/imgOnboarding"
        android:layout_marginBottom="-1dp" />

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:orientation="vertical"
        android:gravity="top|center_horizontal"
        android:paddingHorizontal="32dp"
        android:paddingTop="20dp"
        app:layout_constraintTop_toBottomOf="@id/imgOnboarding"
        app:layout_constraintBottom_toBottomOf="parent">

        <TextView
            android:id="@+id/textTitle"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Welcome"
            android:textSize="34sp"
            android:textStyle="bold"
            android:fontFamily="@font/montserrat_bold"
            android:textColor="#0f172a"
            android:textAlignment="center"
            android:layout_marginBottom="16dp"/>

        <TextView
            android:id="@+id/textDescription"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Description goes here."
            android:textSize="18sp"
            android:fontFamily="@font/montserrat_regular"
            android:textColor="#475569"
            android:textAlignment="center"
            android:lineSpacingMultiplier="1.2"/>
            
    </LinearLayout>

</androidx.constraintlayout.widget.ConstraintLayout>
EOF

echo "DONE! Wavy border applied."