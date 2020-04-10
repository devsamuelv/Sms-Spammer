package com.devsamuel.spam;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.PendingIntent;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.provider.ContactsContract;
import android.telephony.SmsManager;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.NumberPicker;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import java.lang.reflect.Array;
import java.util.Arrays;

public class MainActivity extends AppCompatActivity {

    private int SMS_PERMISION_CODE = 1;

    public SmsManager smsManager = SmsManager.getDefault();
    public Button button = null;
    public TextView output = null;
    public TextView phone = null;
    public Switch isOutputEnabled = null;
    public Button setup = null;
    public TextView sentMsg = null;
    public EditText MESSAGE_TO_SEND = null;
    public ImageView githubRepo = null;
    public TextView chooseMsgNum = null;

    public String RECEVING_NUMBER = "";

    public String message = "hello skyler";
    public boolean START = false;

    public int sent = 0;

    // TODO: 3/13/2020 Get Phone Number Input Working 

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        button = findViewById(R.id.button);
        output = findViewById(R.id.output);
        setup = findViewById(R.id.setup);
        sentMsg = findViewById(R.id.sentMsg);
        githubRepo = findViewById(R.id.githubRepoLink);
        chooseMsgNum = findViewById(R.id.nummsgbtn);

        MESSAGE_TO_SEND = findViewById(R.id.editText);
        
        phone = findViewById(R.id.number);
        isOutputEnabled = findViewById(R.id.isOutputEnabled);

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getPermisions();
            }
        });
        isOutputEnabled.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isOutputEnabled.isChecked()) {
                    output.setVisibility(View.VISIBLE);
                } else {
                    output.setVisibility(View.INVISIBLE);
                }
            }
        });
        githubRepo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent i = new Intent(Intent.ACTION_VIEW);
                i.setData(Uri.parse("https://github.com/DevSamuelV/Sms-Spammer"));
                startActivity(i);
            }
        });

        // object settings go here
        output.setVisibility(View.INVISIBLE);
        setup.setVisibility(View.INVISIBLE);
    }

    @Override
    public void onLowMemory() {
        Toast.makeText(this, "⛔ Low On Memory ⛔", Toast.LENGTH_SHORT).show();
    }

    public void imageSpam() {
        setRECEVING_NUMBER(phone.getText().toString());
        setMessage();
    }

    public void Spam() {
        // you lose half of the messages in sending

        setRECEVING_NUMBER(phone.getText().toString());
        setMessage();

        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();

        // this will be changed for the dropdown box
        if (RECEVING_NUMBER.equals("")) {
            Toast.makeText(this, "Please Enter A Phone Number", Toast.LENGTH_LONG).show();
            return;
        }

        // to check if the amount of messages
        if (getMsgNumbers() > 500) {
            Toast.makeText(this, "Please Enter a message amount lower than 500", Toast.LENGTH_LONG).show();
            return;
        }

        // sends the messages to the receiver.
        for (int i = 0; i < getMsgNumbers(); i++) {
            try {
                PendingIntent pendingIntent = PendingIntent.getActivity(getApplicationContext(), 0, new Intent(), 0);

                smsManager.sendTextMessage(RECEVING_NUMBER, null, message, pendingIntent, null);
                setOutput("Message Sent To " + RECEVING_NUMBER);
                sentMessageNumbers();
            } catch (Exception e) {
                setOutput(e.getMessage());
            }
        }
    }

    public void getPermisions() {
        if (ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED) {
            Spam();
        } else {
            GetSmsPermisions();
        }
    }

    private void GetSmsPermisions() {
        if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.SEND_SMS)) {
            new AlertDialog.Builder(this)
                    .setTitle("Permission Request")
                    .setMessage("Needed To Start Spamming")
                    .setPositiveButton("✔", new OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            ActivityCompat.requestPermissions(MainActivity.this, new String[] {Manifest.permission.SEND_SMS}, SMS_PERMISION_CODE);
                        }
                    })
                    .setNegativeButton("❌", new OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();
                        }
                    })
                    .create().show();
        } else {
            ActivityCompat.requestPermissions(this, new String[] {Manifest.permission.SEND_SMS}, SMS_PERMISION_CODE);
        }
    }

    private int getMsgNumbers() {
        return Integer.parseInt(chooseMsgNum.getText().toString());
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == SMS_PERMISION_CODE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(this, "Permission Granted", Toast.LENGTH_LONG).show();
            } else {
                Toast.makeText(this, "Permission Denied", Toast.LENGTH_LONG).show();
            }
        }
    }

    @SuppressLint("SetTextI18n")
    private void setOutput(String text) {
        String previousText = output.getText().toString();

        output.setText(previousText + " " + text);
    }

    private void setRECEVING_NUMBER(String number) {
        RECEVING_NUMBER = number;
    }

    private void setMessage() {
        message = MESSAGE_TO_SEND.getText().toString();
    }

    @SuppressLint("SetTextI18n")
    private void sentMessageNumbers() {
        sent ++;
        sentMsg.setText("Number Of Sent Messages: " + sent);
    }
}