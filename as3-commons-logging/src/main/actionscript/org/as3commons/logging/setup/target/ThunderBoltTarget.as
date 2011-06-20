/*
 * Copyright (c) 2008-2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.as3commons.logging.setup.target {
	
	import org.as3commons.logging.util.LogMessageFormatter;
	import org.as3commons.logging.level.DEBUG;
	import org.as3commons.logging.level.ERROR;
	import org.as3commons.logging.level.FATAL;
	import org.as3commons.logging.level.INFO;
	import org.as3commons.logging.level.WARN;
	import org.as3commons.logging.setup.ILogTarget;
	import org.osflash.thunderbolt.Logger;
	
	/**
	 * @author Martin Heidegger
	 */
	public final class ThunderBoltTarget implements ILogTarget {
		
		public static const DEFAULT_FORMAT:String = "{logTime} {name}{atPerson}: {message}";
		
		private var _formatter : LogMessageFormatter;
		
		public function ThunderBoltTarget( format:String=null ) {
			// Exclude time, the time of our logger is more accurate
			Logger.includeTime = false;
			// It will use the wrong caller, so just disable it
			Logger.showCaller = false;
			this.format = format;
		}
		
		public function set format( format:String ): void {
			_formatter = new LogMessageFormatter( format||DEFAULT_FORMAT );
		}
		
		public function log( name:String, shortName:String, level:int,
							 timeStamp:Number, message:*, parameters:Array,
							 person:String=null): void {
			if( message is String || parameters.length != 0 ) {
				message = _formatter.format(name, shortName, level, timeStamp, message, parameters );
			}
			switch( level ) {
				case DEBUG:
					Logger.debug(message);
					break;
				case INFO:
					Logger.info(message);
					break;
				case WARN:
					Logger.warn(message);
					break;
				case ERROR:
					Logger.error(message);
					break;
				case FATAL:
					Logger.error(message);
					break;
			}
		}
	}
}
