<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

/*******************************
#
## System Model
#
 *******************************/

class System extends Model
{


    /********************************************
    ## RandomStringNum
     *********************************************/
    public static function RandomStringNum($length)
    {
        $key = '';
        $keys = array_merge(range(0, 9), range('a', 'z'), range(0, 9), range('A', 'Z'));
        for ($i = 0; $i < $length; $i++) {
            $key .= $keys[array_rand($keys)];
        }
        return $key;
    }



    /********************************************
    ## get_client_ip
     *********************************************/
    public static function get_client_ip() {
        $ipaddress = '';
        if (getenv('HTTP_CLIENT_IP'))
            $ipaddress = getenv('HTTP_CLIENT_IP');
        else if(getenv('HTTP_X_FORWARDED_FOR'))
            $ipaddress = getenv('HTTP_X_FORWARDED_FOR');
        else if(getenv('HTTP_X_FORWARDED'))
            $ipaddress = getenv('HTTP_X_FORWARDED');
        else if(getenv('HTTP_FORWARDED_FOR'))
            $ipaddress = getenv('HTTP_FORWARDED_FOR');
        else if(getenv('HTTP_FORWARDED'))
            $ipaddress = getenv('HTTP_FORWARDED');
        else if(getenv('REMOTE_ADDR'))
            $ipaddress = getenv('REMOTE_ADDR');
        else
            $ipaddress = 'UNKNOWN';

        if($ipaddress=='::1')
            $ipaddress = getHostByName(getHostName());

        return $ipaddress;
    }



    /********************************************
    ## getBrowser
     *********************************************/

    public static function getBrowser(){

        $u_agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT']:'Unknown';
        $bname = 'Unknown';
        $platform = 'Unknown';
        $version= '';

        //First get the platform?
        if(preg_match("/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", $u_agent)){

            preg_match("/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", $u_agent,$matches);

            $platform = $matches[0];

        }
        elseif (preg_match('/linux/i', $u_agent)) {
            $platform = 'linux';

        }elseif (preg_match('/macintosh|mac os x/i', $u_agent)) {
            $platform = 'mac';
        } elseif(preg_match('/windows|win32/i', $u_agent)) {
            $platform = 'windows';
        } else {
            $platform = 'Unknown';
        }

        // Next get the name of the useragent yes seperately and for good reason
        if(preg_match('/MSIE/i',$u_agent) && !preg_match('/Opera/i',$u_agent)) {
            $bname = 'Internet Explorer';
            $ub = "MSIE";
        } elseif(preg_match('/Firefox/i',$u_agent)) {
            $bname = 'Mozilla Firefox';
            $ub = "Firefox";
        } elseif(preg_match('/Chrome/i',$u_agent)) {
            $bname = 'Google Chrome';
            $ub = "Chrome";
        } elseif(preg_match('/Safari/i',$u_agent)) {
            $bname = 'Apple Safari';
            $ub = "Safari";
        } elseif(preg_match('/Opera/i',$u_agent)) {
            $bname = 'Opera';
            $ub = "Opera";
        } elseif(preg_match('/Netscape/i',$u_agent)) {
            $bname = 'Netscape';
            $ub = "Netscape";
        } else {
            $bname = 'Netscape';
            $ub='Unknown';
        }

        // finally get the correct version number
        $known = array('Version', $ub, 'other');
        $pattern = '#(?<browser>' . join('|', $known) .
            ')[/ ]+(?<version>[0-9.|a-zA-Z.]*)#';
        if (!preg_match_all($pattern, $u_agent, $matches)) {
            // we have no matching number just continue
        }
        // see how many we have
        $i = count($matches['browser']);
        if ($i != 1) {
            //we will have two since we are not using 'other' argument yet
            //see if version is before or after the name
            if (strripos($u_agent,"Version") < strripos($u_agent,$ub)){
                $version= isset($matches['version'][0])?$matches['version'][0]:'';
            } else {
                $version= isset($matches['version'][1]) ? $matches['version'][1]:'';
            }
        }
        else {
            $version= isset($matches['version'][0])?$matches['version'][0]:'';
        }

        // check if we have a number
        if ($version==null || $version=="") {$version="?";}

        return array(
            'userAgent' => $u_agent,
            'browser'   => $bname,
            'version'   => $version,
            'platform'  => $platform,
        );
    }


    /********************************************
    ## ForgotPasswordEmail
     *********************************************/
    public static function ForgotPasswordEmail($users_id,$reset_url){



        $now = date('Y-m-d H:i:s');

        try{

            $user_info=\App\User::where('id',$users_id)->first();

            if(isset($user_info)){
                $users_id=$user_info->id;
                $users_type=$user_info->user_type;
                $users_email=$user_info->email;

            }else{
                return \Redirect::back()->with('message',"Invalid User ID!");
            }

            $data['user_info'] = $user_info;
            $data['reset_url'] = $reset_url;

            $user_email = $users_email;
            $user_name = $user_info->name;


            \Mail::send('forgot.forget-password-mail', $data, function($message) use ($user_email,$user_name) {

                $message->to($user_email,$user_name)->subject('Password Recovery');

            });

            \App\System::EventLogWrite('send-mail,forget-password-verification',json_encode($data));
            \Session::flash('errormessage', 'Please check your inbox!');
            return true;

        }catch (\Exception $e){

            $message = "Message : ".$e->getMessage().", File : ".$e->getFile().", Line : ".$e->getLine();
            \App\System::ErrorLogWrite($message);
            \Session::flash('errormessage', $e->getMessage());
            return false;
        }

    }





    /**********************************************************
    ## MSISDNTrack
     *************************************************************/

    public static function MSISDNTrack(){

        if(isset($_SERVER['USER_IDENTITY_FORWARD_MSISDN']))
        {
            $mobile_number = trim($_SERVER['HTTP_X_UP_CALLING_LINE_ID']);
        }
        else if(isset($_SERVER['HTTP_MSISDN']))
        {
            $mobile_number = trim($_SERVER['HTTP_MSISDN']);
        }
        else if(isset($_SERVER['HTTP_X_FH_MSISDN']))
        {
            $mobile_number = trim($_SERVER['HTTP_X_FH_MSISDN']);
        }
        else if(isset($_SERVER['HTTP_X_HTS_CLID']))
        {
            $mobile_number = trim($_SERVER['HTTP_X_HTS_CLID']);
        }
        else if(isset($_SERVER['HTTP_X_UP_CALLING_LINE_ID']))
        {
            $mobile_number = trim($_SERVER['HTTP_X_UP_CALLING_LINE_ID']);
        }
        else if(isset($_SERVER['HTTP-ALL-RAW']))
        {
            $mobile_number = trim($_SERVER['HTTP-ALL-RAW']);
        }
        else if(isset($_SERVER['HTTP-HOST']))
        {
            $mobile_number = trim($_SERVER['HTTP-HOST']);
        }
        else if(isset($_SERVER['x-msisdn']))
        {
            $mobile_number = trim($_SERVER['x-msisdn']);
        }
        else if(isset($_SERVER['HTTP-x-msisdn']))
        {
            $mobile_number = trim($_SERVER['HTTP-x-msisdn']);
        }
        else if(isset($_SERVER['x-h3g-msisdn']))
        {
            $mobile_number = trim($_SERVER['x-h3g-msisdn']);
        }
        else if(isset($_SERVER['HTTP-x-h3g-msisdn']))
        {
            $mobile_number = trim($_SERVER['HTTP-x-h3g-msisdn']);
        }
        else if(isset($_SERVER['HTTP-X-MSISDN-Alias']))
        {
            $mobile_number = trim($_SERVER['HTTP-X-MSISDN-Alias']);
        }
        else if(isset($_SERVER['X-MSISDN-Alias']))
        {
            $mobile_number = trim($_SERVER['X-MSISDN-Alias']);
        }
        else if(isset($_SERVER['HTTP-x-h3g-msisdn']))
        {
            $mobile_number = trim($_SERVER['HTTP-x-h3g-msisdn']);
        }
        else if(isset($_SERVER['HTTP-msisdn']))
        {
            $mobile_number = trim($_SERVER['HTTP-msisdn']);
        }
        else if(isset($_SERVER['msisdn']))
        {
            $mobile_number = trim($_SERVER['msisdn']);
        }
        else if(isset($_SERVER['MSISDN']))
        {
            $mobile_number = trim($_SERVER['MSISDN']);
        }
        else if(isset($_SERVER['X-WAP-PROFILE']))
        {
            $mobile_number = trim($_SERVER['X-WAP-PROFILE']);
        }
        else if(isset($_SERVER['X-UP-CALLING-LINE-ID ']))
        {
            $mobile_number = trim($_SERVER['X-UP-CALLING-LINE-ID ']);
        }
        else if(isset($_SERVER['X-H3G-MSISDN']))
        {
            $mobile_number = trim($_SERVER['X-H3G-MSISDN']);
        }
        else if(isset($_SERVER['X-FH-MSISDN ']))
        {
            $mobile_number = trim($_SERVER['X-FH-MSISDN ']);
        }
        else if(isset($_SERVER['X-MSP-MSISDN']))
        {
            $mobile_number = trim($_SERVER['X-MSP-MSISDN']);
        }
        else if(isset($_SERVER['X-INTERNET-MSISDN']))
        {
            $mobile_number = trim($_SERVER['X-INTERNET-MSISDN']);
        }
        else if(isset($_SERVER['X_MSISDN']))
        {
            $mobile_number = trim($_SERVER['X_MSISDN']);
        }
        else if(isset($_SERVER['HTTP_X_MSISDN']))
        {
            $mobile_number = trim($_SERVER['HTTP_X_MSISDN']);
        }

        if (isset($mobile_number)) {

            return $mobile_number;

        } else {
            return 'NO_MSISDN';
        }
    }

    /**********************************************************
    ## MobileDesktopPlatformCheck
     *************************************************************/

    public static function MobileDesktopPlatformCheck(){

        $_SERVER['ALL_HTTP'] = isset($_SERVER['ALL_HTTP']) ? $_SERVER['ALL_HTTP'] : '';

        $mobile_browser = '0';

        $agent = isset($_SERVER['HTTP_USER_AGENT'])?strtolower($_SERVER['HTTP_USER_AGENT']):'';

        if(preg_match('/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|iphone|ipad|ipod|android|xoom)/i', $agent))
            $mobile_browser++;

        if((isset($_SERVER['HTTP_ACCEPT'])) and (strpos(strtolower($_SERVER['HTTP_ACCEPT']),'application/vnd.wap.xhtml+xml') !== false))
            $mobile_browser++;

        if (strpos(strtolower($agent),' ppc;')>0) {
            $mobile_browser++;
        }
        if(isset($_SERVER['HTTP_X_WAP_PROFILE']))
            $mobile_browser++;

        if(isset($_SERVER['HTTP_PROFILE']))
            $mobile_browser++;

        $mobile_ua = substr($agent,0,4);
        $mobile_agents = array(
            'w3c ','acs-','alav','alca','amoi','audi','avan','benq','bird','blac',
            'blaz','brew','cell','cldc','cmd-','dang','doco','eric','hipt','inno',
            'ipaq','java','jigs','kddi','keji','leno','lg-c','lg-d','lg-g','lge-',
            'maui','maxo','midp','mits','mmef','mobi','mot-','moto','mwbp','nec-',
            'newt','noki','oper','palm','pana','pant','phil','play','port','prox',
            'qwap','sage','sams','sany','sch-','sec-','send','seri','sgh-','shar',
            'sie-','siem','smal','smar','sony','sph-','symb','t-mo','teli','tim-',
            'tosh','tsm-','upg1','upsi','vk-v','voda','wap-','wapa','wapi','wapp',
            'wapr','webc','winw','xda','xda-'
        );

        if(in_array($mobile_ua, $mobile_agents))
            $mobile_browser++;

        if(strpos(strtolower($_SERVER['ALL_HTTP']), 'operamini') !== false)
            $mobile_browser++;
        //if((strpos(strtolower($_SERVER['HTTP_USER_AGENT']), ‘windows’) !== false) && (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), ‘phone’) !== true))
        // Pre-final check to reset everything if the user is on Windows
        if(strpos($agent, 'windows') !== false)
            $mobile_browser=0;

        // But WP7 is also Windows, with a slightly different characteristic
        if(strpos($agent, 'windows phone') !== false)
            $mobile_browser++;
        if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),'windows ce')>0) {
            $mobile_browser++;
        }
        else if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),'windows')>0) {
            $mobile_browser=0;
        }

        if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),'iemobile')>0) {
            $mobile_browser++;
        }

        if($mobile_browser >0)
            return 'mobile';
        else
            return 'desktop';
    }


    /**********************************************************
    ## MultiArraySerach
     *************************************************************/

    public static function MultiArraySerach($search,$search_key,$array){

        foreach ($array as $key => $value) {
            if ($value[$search_key] == $search) {
                return $key;
            }
        }
        return -1;
    }


####################### End #####################################
}
