import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Weather;
using Toybox.Activity;

class StarryWatchFaceView extends WatchUi.WatchFace {

    var timeLable, dateLabel,tempLabel, heartRateLabel;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        //Reference labels
       timeLable = View.findDrawableById("TimeLabel") as Text;
       dateLabel = View.findDrawableById("DateLabel") as Text;
       tempLabel = View.findDrawableById("TempLabel") as Text;
       heartRateLabel = View.findDrawableById("HeartRateLabel") as Text;

        //position labels
       timeLable.setLocation(dc.getWidth()/2, (dc.getHeight()/2)-(dc.getHeight()/3.6));
       dateLabel.setLocation(dc.getWidth()/2, (dc.getHeight()/2)-(dc.getHeight()/2.7));
       tempLabel.setLocation(dc.getWidth()/2+(dc.getWidth()/3.5), (dc.getHeight()/2)+(dc.getHeight()/23));
       heartRateLabel.setLocation(dc.getWidth()/2, (dc.getHeight()/2)+(dc.getHeight()/23));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        //get properties
        var textColor = Properties.getValue("TextColor");
        //set labels color
        setLabelsColor(textColor);
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        timeLable.setText(timeString);

        //get current date and format
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateFormat = "$1$ $2$";
        var dateString = Lang.format(dateFormat, [today.day,today.month]);
        dateLabel.setText(dateString);
       
       //get current temp and format
        var temp = Weather.getCurrentConditions().temperature;
        if(temp!=null){
            var tempString = Lang.format("$1$°", [temp]);
            tempLabel.setText(tempString);
        }
        
        //get current heart rate and format
        var heartRate = Activity.getActivityInfo().currentHeartRate;
        heartRateLabel.setText(heartRate!=null?heartRate.toString():"--");
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
      
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }
    // set or change the labels color
    function setLabelsColor( color as Number) as Void{
        me.timeLable.setColor(color);
        me.dateLabel.setColor(color);
        me.tempLabel.setColor(color);
        me.heartRateLabel.setColor(color);
    }

}
