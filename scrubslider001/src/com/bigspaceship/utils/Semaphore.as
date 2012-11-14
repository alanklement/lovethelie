/*
Copyright (C) 2006 Big Spaceship, LLC

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

To contact Big Spaceship, email info@bigspaceship.com or write to us at 45 Main Street #716, Brooklyn, NY, 11201.
*/
package com.bigspaceship.utils {
	import com.bigspaceship.events.SemaphoreEvent;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	
	public class Semaphore extends EventDispatcher {
		private var _id          : String;
		private var _locks       : Dictionary;
		private var _numlocks    : Number = 0;
		private var _numunlocked : Number = 0;
		
		
		public function Semaphore($id:String, $locks:Array = null):void {
			var l:Array  = $locks ? $locks : new Array();
			var i:Number = l.length;
			
			_id    = ($id ? $id : Math.round(Math.random() * 100000)).toString();
			_locks = new Dictionary(true);
			
			if(i) while(i--) addLock(l[i]);
		};
		
		
		public function openLock($l:String):Boolean {
			_locks[$l] = true;
			
			_numunlocked++;
			
			if(isUnlocked) {
	            // Fires an onUnlock event the very moment the final
	            // condition has been met.  You can either subscribe 
	            // to this event or test the returned value.
				dispatchEvent(new SemaphoreEvent(SemaphoreEvent.UNLOCK, _id));	
				
				return true;
				
			} else {
				return false;
				
			};
		};
		
			
	    public function resetLocks():void {
	        // Intended to be called prior to reuse of a semaphore instance.
	        var l:String;
	        
	        for(l in _locks) _locks[l] = false;
	        
	        _numunlocked = 0;
	    };
	    
	    
	    public function get isLocked():Boolean {
	    	var v:Boolean;
	    	
	    	for each(v in _locks) {
	    		if(v) {
	    			// If there is an open lock, isLocked = false;
	    			return false;
	    		};
	    	};
	    	
	    	return true;
	    };
	    
	    
	    public function get isUnlocked():Boolean {
	        // If every stored condition has been marked "true", then
	        // returns true
	        var v:Boolean;

	        for each(v in _locks) {
	        	if(!v) {
	        		return false;
	        	};
	        };
	
	        return true;
	    }; 
	    
	    
		public function get countLocked():Number {
			return _numlocks - _numunlocked;
		};
	    
	    
		public function get countUnlocked():Number {
			return _numunlocked;
		};
		
		
		public function get countLocks():Number {
			return _numlocks;
		};
	    
	    
		
		// WARNING: Functionality you should think twice about using, because
		// it may result in serious logic issues if you're not careful.  A
		// semaphore should be filled with a static number of locks and not
		// modified afterwards.  Locks can be opened, but all locks should be
		// reset simultaneously.  
		public function addLock($l:String):void {
			_numlocks++;
			
			_locks[$l] = false;
		};
		
		
		public function removeLock($l:String):void {
	        // I'm not sure if it's a good idea to remove locks
	        // but I guess I'll leave in the ability to do it.
	        _numlocks--;
	        
			delete _locks[$l];
		};
		
		
		public function closeLock($l:String):void {
	        // I'm not sure if it's a good idea to re-close locks either,
	        // but I guess I'll leave in the ability to do it.  Just don't
	        // do it often.
			_locks[$l] = false;
			
			_numunlocked--;
		};
		
	};
};