<?php
# -- BEGIN LICENSE BLOCK ----------------------------------
#
# This file is part of Mage Pattern.
# The toolkit PHP for developer
# Copyright (C) 2012 - 2013 Gerits Aurelien contact[at]aurelien-gerits[dot]be
#
# OFFICIAL TEAM MAGE PATTERN:
#
#   * Gerits Aurelien (Author - Developer) contact[at]aurelien-gerits[dot]be
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# DISCLAIMER

# Do not edit or add to this file if you wish to upgrade Mage Pattern to newer
# versions in the future. If you wish to customize Mage Pattern for your
# needs please refer to http://www.magepattern.com for more information.
#
# -- END LICENSE BLOCK -----------------------------------

class date_dateformat extends DateTime{
	/**
	 * création de l'objet datetime
	 * @param string $time
	 * @param DateTimeZone $timezone
     * @return \DateTime
     */
	private function create($time = "now", DateTimeZone $timezone = NULL){
		if ($timezone != NULL)
			return new parent($time, $timezone);
		else
			return new parent($time);
	}
    /**
     * Instance la classe DateTime
     * @param  $time
     * @return \DateTime
     * @throws Exception
     */
    private function _datetime($time){
        try {
            $datetime = self::create($time);
            if($datetime instanceof DateTime){
                return $datetime;
            }else{
                throw new Exception('not instantiate the class: DateTime');
            }
        }catch(Exception $e) {
            $logger = new debug_logger(MP_LOG_DIR);
            $logger->log('php', 'error', 'An error has occured : '.$e->getMessage(), debug_logger::LOG_MONTH);
        }
    }
    /**
     * @access public
     * Test la validité de la date
     * @param integer $y
     * @param integer $m
     * @param integer $d
     * @return bool
     * @static
     */
	public static function isValid( $y = null, $m = null, $d = null ){
		if ( $y === null || $m === null || $d === null ) return false ;
		return checkdate( $m, $d, $y ) ;
	}
    /**
     * W3C date Format
     * @param $str
     * @return void
     */
    public static function isW3CValid($str) {
        $stamp = strtotime( $str );
        if (!is_numeric($stamp))
        {
            return false;
        }
        $month = date( 'm', $stamp );
        $day   = date( 'd', $stamp );
        $year  = date( 'Y', $stamp );

        if (checkdate($month, $day, $year))
        {
            return $str;
        }

        return false;
    }
	/**
	 * 
	 * @param string $format
	 * @param string $time
     * @return string
     */
	public function dateDefine($format='Y-m-d',$time=null){
		return $this->_datetime($time)->format($format) ;
	}

    /**
     * @access public
     * Retourne la date au format européen avec slash (2000/01/01)
     * @param null $time
     * @internal param \timestamp $date
     * @return string
     * @example
     * $datecreate = new date_dateformat();
     * echo $datecreate->dateToEuropeanFormat('2000-01-01');
     */
	public function dateToEuropeanFormat($time=null){
		return $this->dateDefine('Y/m/d',$time);
	}

    /**
     * Transforme une date au format européen en format SQL
     * @param $d
     * @param string $separator
     * @return string
     */
    public function dateToDbFormat($d,$separator = '/'){
        list($day, $month, $year) = explode($separator, $d);
        return "$year-$month-$day";
    }
    /**
     * @access public
     * Retourne la date au format W3C
     * $datecreate = new date_dateformat();
     * echo $datecreate->dateW3C('2005-08-15');
     * 2005-08-15T15:52:01+00:00
     * @param null $time
     * @return string
     */
	public function dateW3C($time=null){
		return $this->dateDefine(DATE_W3C,$time);
	}

    /**
     * @access public
     * Retourne le timestamp au format unix
     * @param null $time
     * @return int|string
     */
	public function getTimestamp($time=null){
		return $this->dateDefine("U",$time);
	}

    /**
     * @access public
     * Retourne la date au format SQL
     * @param null $time
     * @return string
     */
	public function SQLDate($time=null){
		return $this->dateDefine("Y-m-d",$time);
	}

    /**
     * @access public
     * Retourne la date et l'heure au format SQL
     * @param null $time
     * @return string
     */
	public function SQLDateTime($time=null){
		return $this->dateDefine("Y-m-d H:i:s",$time);
	}

    /**
     * @access public
     * Retourne la différence entre deux dates
     * @param $time1
     * @param $time2
     * @param string $return_f
     * @return mixed
     * @internal param string $dateTime
     */
	public function dateDiff($time1,$time2,$return_f = '%R%a'){
		$datetime1 = $this->_datetime($time1);
		$datetime2 = $this->_datetime($time2);
		$interval = $datetime1->diff($datetime2, false);
        return $interval->format($return_f);
	}

    /**
     * @access public
     * Retourne la date Modifiée
     * @param string $modify
     * @param string $format
     * @param null $time
     * @throws Exception
     * @return \DateTime|string DateTime
     * @example :
        $dateformat = new date_dateformat();
        $dateformat->modify('+1 day',"Y-m-d H:i:s");
     */
    public function modify($modify,$format='Y-m-d',$time=null){
        if($modify != null){
            $datetime = $this->_datetime($time);
            $datetime->modify($modify);
            return $datetime->format($format);
        }else{
            throw new Exception('dateformat params modify is null');
        }
    }

    /**
     * @param array $interval_spec
     * @return DateInterval
     * @throws Exception
     */
    private function optionInterval($interval_spec=array('interval'=>'','type'=>'string')){
        if(isset($interval_spec['interval'])){
            $interval = $interval_spec['interval'];
        }else{
            throw new Exception('');
        }
        if(isset($interval_spec['type'])){
            $type = $interval_spec['type'];
        }else{
            $type = 'string';
        }
        switch($type){
            case 'string':
                $duration = DateInterval::createFromDateString($interval);
                break;
            case 'object':
                $duration = new DateInterval($interval);
                break;
        }
        return $duration;
    }

    /**
     * Retourne une date sous forme d'object dateTime (P7Y5M4D)
     * @param $time
     * @param string $config
     * @return string
     */
    public function setInterval($time,$config='YMD'){
        $datetime = $this->_datetime($time);
        $format = '';
        if(strpos($config,'Y') !== false){
            if($datetime->format('y') != null){
                $format .= $datetime->format('y').'Y';
            }
        }
        if(strpos($config,'M') !== false){
            if($datetime->format('m') != null){
                $format .= $datetime->format('m').'M';
            }
        }
        if(strpos($config,'D') !== false){
            if($datetime->format('d') != null){
                $format .= $datetime->format('d').'D';
            }
        }
        return 'P'.$format;
    }

    /**
     * Retourne sous forme de chaine l'état de différence entre deux dates
     * @param $time1
     * @param $time2
     * @return string
     * @example :
        $date = new date_dateformat();
        $datestart = $date->dateDefine('2012-01-01');
        $interval = $date->setInterval('2012-01-01','D');
        $dateend = $date->add(
        array('interval'=>$interval,'type'=>'object'),
            'Y-m-d',
            '2012-01-30'
        );
        print $date->getStateDiff($dateend,$datestart);
        Return expired
     *
     *
     */
    public function getStateDiff($time1,$time2){
        $interval = $this->dateDiff($time1,$time2,$return_f = '%R%a');
        if($interval > 0){
            $datestate = 'current';
        }elseif($interval == 0){
            $datestate = 'lastday';
        }else{
            $datestate = 'expired';
        }
        return $datestate;
    }
    /**
     * Ajoute une durée à un objet DateTime
     * @param array|\DateInterval $interval_spec
     * @param string $format
     * @param null $time
     * @throws Exception
     * @return \DateTime|string DateTime
     * @example :
     Utilisation avec object dateTime
     $dateformat->add(
        array('interval'=>'P10D','type'=>'object'),
        'Y-m-d H:i:s',
        '2009-10-13'
     );
     Utilisation avec chaine pour la durée
     $dateformat->add(
        array('interval'=>'+1 day','type'=>'string'),
        'Y-m-d H:i:s',
        '2009-10-13'
     );
     */
    public function add(array $interval_spec,$format='Y-m-d',$time=null){
        if(is_array($interval_spec)){
            $datetime = $this->_datetime($time);
            $duration = $this->optionInterval($interval_spec);
            $datetime->add($duration);
            return $datetime->format($format);
        }else{
            throw new Exception('dateformat params interval_spec is not array');
        }
    }

    /**
     * Soustrait la durée spécifiée par l'objet DateInterval de l'objet DateTime.
     * @param array|\DateInterval $interval_spec
     * @param string $format
     * @param null $time
     * @throws Exception
     * @return \DateTime
     Utilisation avec object dateTime
     $dateformat->sub(
        array('interval'=>'P10D','type'=>'object'),
        'Y-m-d H:i:s',
        '2009-10-13'
     );
     Utilisation avec chaine pour la durée
     $dateformat->sub(
        array('interval'=>'+1 day','type'=>'string'),
        'Y-m-d H:i:s',
        '2009-10-13'
     );
     */
    public function sub(array $interval_spec,$format='Y-m-d',$time=null){
        if($interval_spec != null){
            $datetime = $this->_datetime($time);
            $duration = $this->optionInterval($interval_spec);
            $datetime->sub($duration);
            return $datetime->format($format);
        }else{
            throw new Exception('dateformat params interval is null');
        }
    }

    /**
     * Configure une date ISO
     * @param $year
     * @param $month
     * @param int $day
     * @param string $format
     * @return mixed
     * @example :
     * $dateformat->isoDate(2008, 2);
     * $dateformat->isoDate(2008, 2, 7);
     */
    public function isoDate($year, $month, $day=1,$format='Y-m-d'){
        $datetime = $this->_datetime(null);
        $datetime->setISODate($year, $month, $day);
        return $datetime->format($format);
    }
    /**
     * Assigne la date courante de l'objet à une nouvelle date.
     * @param $year
     * @param $month
     * @param $day
     * @param string $format
     * @return mixed
     * @example :
     * $dateformat->assignDate(2008, 2, 1);
     */
    public function assignDate($year, $month, $day,$format='Y-m-d'){
        $datetime = $this->_datetime(null);
        $datetime->setDate($year, $month, $day);
        return $datetime->format($format);
    }
}
?>