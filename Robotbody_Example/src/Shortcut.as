/*******************************************
 * author	: Redbug
 * e-mail	: l314kimo@gmail.com
 * blog		: http://redbug0314.blogspot.com
 * purpose	:		
 *******************************************/

package
{
    import flash.text.TextField;
    
    public class Shortcut
    {
        private var _key_txt     :TextField;
        private var _func_txt    :TextField;
        
        public function Shortcut()
        {
            super();
        }
        
        public function get key_txt():TextField
        {
            return _key_txt;
        }

        public function set key_txt(value:TextField):void
        {
            _key_txt = value;
        }

        public function get func_txt():TextField
        {
            return _func_txt;
        }

        public function set func_txt(value:TextField):void
        {
            _func_txt = value;
        }


    }
}