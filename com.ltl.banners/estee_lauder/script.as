import caurina.transitions.*
stop();

var p2frame:Number = 1

//
//  COLLAPSE BANNER HERE:
//
//
function collapse() {
	_parent.gotoAndStop(1)
}

/// start app
III();
animate_corners(1, 1);
PSRS(1);
resizeMain(1);
DRRS();

function III() {

	
	this.page_width = 300;// -------PageWidth.
	this.page_height = 250;// -------PageHeight.
	this.page_color = 0x070707;// --PageColor.
	this.num_of_pages = 8;// --------Number of Pages - Be sure to assign print clips in library a "LINKAGE IDENTIFIER" (right-click/linkage).
	this.auto_step = .08;// -------AutoStep - How fast pages turn when autoFlipping (0 to 1).
	this.snap = .002;// ------Snap - How close to laying flat the page needs to be before a flip is considered done (0 to 1).
	this.drag = .4;// --------Drag - How smooth the page will move when being dragged by hand or autoFlipping (0 to 1).
	this.drag_advance = 40;// --------DragAdvance - Positions the corner buttons (in pixels).
	this.show_corner_btns = true; // -----ShowCornerButtons (true or false).
	this.page_width_height = page_width+page_height;
	this.PY = page_height/2+page_width;
	this.DD = 1;		//1
	this.VR = -1;		//-1
	this.ENP = 2.5;		//2.5
	this.current_page = .5;		//0.5
	this.DRG = false;
	this.ODR = 0;

	IB();

	PI(ENP, DD, VR);
	SRP.removeMovieClip();
	
}

function MM() {
	this.createEmptyMovieClip("FBPM", 70);
	with (FBPM) {
		beginFill(0x005500, 100);
		lineTo(page_width_height, -VR*page_width_height);
		curveTo(0, -VR*2*page_width_height, -page_width_height, -VR*page_width_height);
		lineTo(0, 0);
		endFill();
	}
	FBPM.duplicateMovieClip("FTPM", 80);
	FBPM.duplicateMovieClip("FTPM2", 3);
	FTPM2._alpha=0

	this.createEmptyMovieClip("FSM", 90);
	DP(FSM, -DD, VR);
	FSM._rotation = VR*DD*90;
	this.createEmptyMovieClip("SSM", 100);
	DP(SSM, DD, VR);
	FBP.setMask(FBPM);
	
	FTP.setMask(FTPM);
	FS.setMask(FSM);
	SS.setMask(SSM);
}

function L01(rrr) {
	return (rrr>1 ? 1 : rrr<0 ? 0 : rrr);
}

function MSE(t, xq, yq) {
	with (t) {

		var m = {matrixType:"box", x:0, y:-yq*page_width, w:xq*page_width, h:-yq*page_height, r:0};
		beginGradientFill("linear", c, a, ra, m);
		moveTo(0, -page_width*yq);
		lineTo(0, -page_width_height*yq);
		lineTo(xq*page_width, -page_width_height*yq);
		lineTo(xq*page_width, -page_width*yq);
		lineTo(0, -page_width*yq);
		endFill();
	}
}

function GGR() {
	if (DRG) {
		if (this.current_page==0.5) {MRO = -DD*(280-startX-(DD*drag_advance))/(2*page_width)} else {MRO = -DD*(_xmouse-startX-(DD*drag_advance))/(2*page_width);}
	} else {
		MRO>2/3 ? MRO += auto_step : MRO -= auto_step;
	}
	return (L01(MRO));
}

function SAFP(ENP, DD) {
	PI(ENP, DD, VR, true);
	startX = DD*page_width;
	if (show_corner_btns) {
		BRB._visible = BLB._visible=TRB._visible=TLB._visible=BRBN._visible=0;
	}
	PRO = 0;
	FFF(ODR);
	onEnterFrame = function () { FA(L01(PRO += auto_step));};

	current_page = ENP;
}

function SB() {
	var m = -VR*(page_width+page_height/2);
	var e = (page_height/2);
	if (show_corner_btns) {
		BRB._y = BLB._y=m+e; 
		BRBN._y = BLBN._y=m+e;
		IBB._y = IBB._y=m+e;
		TRB._y = TLB._y=m-e;
	}
}

function FA(goalR) {
	step = (goalR-ODR)*drag;
	ODR += step;
	FFF(ODR);
	if (ODR>1-snap) {
		FFF(1);
		FD();
		if (AFG) {
			if (current_page != EAFP) {
				SAFP(current_page+DAF*2, DAF);
			} else {
				AFG = false;
			}
		}
	}
}

function turnTo(ENP) {
	ENP = fixPageNum(ENP);
	if (ENP != current_page) {
		if (!onEnterFrame) {
			var d = ENP>current_page ? 1 : -1;
			SAFP(ENP, d);
		}
	}
}

function fixPageNum(pageNum) {
	var mod = pageNum%2;
	if (mod == 0) {
		return pageNum+.5;
	}
	if (mod == 1) {
		return pageNum-.5;
	}
	return pageNum;
}

function turnBack() {
	if (current_page>.5) {
		turnTo(current_page-2);
	}
}

function turnAhead() {
	if (current_page<num_of_pages) {
		turnTo(current_page+2);
	}
}

function flipTo(targPage) {
	targPage = fixPageNum(targPage);
	if (targPage>current_page) {
		DAF = 1;
	} else if (targPage<current_page) {
		DAF = -1;
	} else {
		return;
	}
	AFG = true;
	EAFP = targPage;
	SAFP(current_page+DAF*2, DAF);
}

function DP(t, xq, yq) {
	with (t) {
		beginFill(page_color, 100);
		moveTo(0, -yq*page_width);
		lineTo(0, -yq*page_width_height);
		lineTo(xq*page_width, -yq*page_width_height);
		lineTo(xq*page_width, -yq*page_width);
		endFill();
	}
}

function FFF(CV) {
	var r = VR*DD*45*CV;
	FBPM._rotation = FTPM._rotation=FTPM2._rotation=-r;

	FBP._rotation = FSM._rotation=VR*(DD*90)-r*2;
	FS._rotation = SS._rotation=VR*(DD*45)-r;
}

function FD() {
	onEnterFrame = null;
	ODR = 0;
	if (show_corner_btns) {
		IBB._visible=false
		BRB._alpha = BLB._alpha=TRB._alpha=TLB._alpha=BRBN._alpha=100;
		if (current_page != .5) {
			BLB._visible = TLB._visible=true;
		} else {
			BLB._visible = TLB._visible=false;
		}
		if (current_page == .5) {
			BRB._visible =true;
			BRBN._visible =false
		} else if (current_page != num_of_pages+.5) {
			BRBN._visible = TRB._visible=true;
			BRB._visible =false;
		} else {
			BRB._visible = BRBN._visible = TRB._visible=false;
		}
	}
	if (PRO == 0) {
		FS.removeMovieClip();
		FSM.removeMovieClip();
		SS.removeMovieClip();
		SSM.removeMovieClip();
		FBP.removeMovieClip();
		FBPM.removeMovieClip();
		if (DD == 1) {
			SRP.removeMovieClip();
		} else {
			SLP.removeMovieClip();
		}
	} else {
		FTP.removeMovieClip();
		if (DD == -1) {
			SRP.removeMovieClip();
		} else {
			SLP.removeMovieClip();
		}
	}
	FTPM.removeMovieClip();
	FTPM2.removeMovieClip();
}

function SSW(isClicked) {
	this.createEmptyMovieClip("FS", 50);
	MSW(FS, -DD, VR);
	FS._rotation = VR*DD*45;
	this.createEmptyMovieClip("SS", 60);
	MSW(SS, DD, VR);
	SS._rotation = VR*DD*45;

}

function LB() {
	if (current_page == .5) {
		SLP._visible = 0;
		FTP.Shade._alpha = 67;
	} else if (current_page == num_of_pages+.5) {
		SRP._visible = 0;
		FTP.Shade._alpha = 67;
	}
	if (ENP == .5) {
		FS._alpha = 67;
		SS._visible = 0;
	} else if (ENP == num_of_pages+.5) {
		FS._alpha = 67;
		SS._visible = 0;
	}
}

function SFG() {
	createEmptyMovieClip("FTP", 30);
	DP(FTP, DD, VR);
	var PN = DD == 1 ? current_page+.5 : current_page-.5;
	with (FTP) {
		attachMovie("print"+PN, "Print", 10);
		with (Print) {
			_x = DD*page_width/2;
			_y = -VR*PY;
		}
	}
	FTP.createEmptyMovieClip("Shade", 20);
	MSE(FTP.Shade, DD, VR);
	createEmptyMovieClip("FBP", 40);
	DP(FBP, -DD, VR);
	var PN = DD == 1 ? ENP-.5 : ENP+.5;
	FBP.attachMovie("print"+PN, "Print", 10);
	with (FBP.Print) {
		_x = -DD*page_width/2;
		_y = -VR*PY;
	}
	FBP._rotation = DD*VR*90;
}

function MSW(t, xq) {
	with (t) {
		var c, a, ra, mxl, m;
		
		mxl = Math.sqrt((page_width*page_width)+(page_width_height*page_width_height));
		m = {matrixType:"box", x:0, y:-VR*mxl, w:xq*page_width, h:VR*(mxl-page_width), r:0};
		beginGradientFill("linear", c, a, ra, m);
		moveTo(0, -VR*page_width);
		lineTo(0, -VR*mxl);
		lineTo(xq*page_width, -VR*mxl);
		lineTo(xq*page_width, -VR*page_width);
		lineTo(0, -VR*page_width);
		endFill();
	}
}

function animate_corners(DD, VR) {
		
	PI(current_page+DD*2, DD, VR);
	startX = DD*page_width;
	DRG = true;
	BRB._alpha = BLB._alpha=TLB._alpha=TRB._alpha=BRBN._alpha=0;
	
	if (this.current_page==0.5)
	{
		BRB._alpha=100;
	}
	
	ODR = 0;
	onEnterFrame = function () {
		var goalR = GGR();
		step = (goalR-ODR)*drag;
		ODR += step;FFF(ODR);
		if (!DRG) {
			if (ODR<snap) {
				FFF(0);
				PRO = 0;
				FD();
			} else if (ODR>1-snap) {
				FFF(1);
				PRO = 1;
				FD();
			}
		}
	};
}

function PI(ep, d, v,isClicked) {
	ENP = ep;
	DD = d;
	VR = v;
	SST();
	SFG();
	SSW(isClicked);
	MM();
	LB();
	SB();
	goBack();
}

function SST() {
	createEmptyMovieClip("SLP", 10);
	if (ENP != .5) {
		DP(SLP, -1, VR);
		var PN = DD == 1 ? current_page-.5 : ENP-.5;
		var SLPP = SLP.attachMovie("print"+PN, "Print", 2);
		SLPP._x = -page_width/2;
		SLPP._y = -VR*PY;
	}
	createEmptyMovieClip("SRP", 20);
	if (ENP != num_of_pages+.5) {
		DP(SRP, 1, VR);
		var PN = DD == 1 ? ENP+.5 : current_page+.5;
		var SRPP = SRP.attachMovie("print"+PN, "Print", 2);
		SRPP._x = page_width/2;
		SRPP._y = -VR*PY;
	}
	var t = DD>0 ? SLP : SRP;
	t.createEmptyMovieClip("Shade", 3);
	MSE(t.Shade, -DD, VR);
}

function DRRS() {
	if (MRO>2/3) {
		current_page += 2*DD;
	}
	PD = DRG=false;
	
	hide_corner_btns();
	
}

function hide_corner_btns()
{
	BRB._visible = BLB._visible=TLB._visible=TRB._visible=false;
}

function PSRS(side) {
	if (PD) {
		PD = false;
	} else {
		flipTo(current_page+side*2);
	}
}

function IB() {

	attachMovie("CBR", "BRB", 110);
	attachMovie("CBRN", "BRBN", 115);
	attachMovie("CBL", "BLB", 120);
	attachMovie("initBTN", "IBB", 125);
	BLB._xscale = TLB._xscale=-100;
	TLB._yscale = TRB._yscale=-100;
	BRB._x = BRBN._x = IBB._x =page_width;
	BLB._x = TLB._x=-page_width;
	BLB._visible = BRBN._visible=false;
	// 
	BLB.onRollOver = function() {
		animate_corners(-1, 1);
	};
	TLB.onRollOver = function() {
		animate_corners(-1, -1);
	};
	IBB.onRollOver = function() {
	};
	BRB.onRollOver = function() {
		animate_corners(1, 1);
		PSRS(1);resizeMain(1);DRRS();
	};
	BRBN.onRollOver = function() {
		animate_corners(1, 1);
	};
	TRB.onRollOver = function() {
		animate_corners(1, -1);
	};
	IBB.onRollOut = BLB.onRollOut = BRB.onRollOut = BRBN.onRollOut = TRB.onRollOut=TLB.onRollOut=function () { DRG = false;};
	BLB.onRelease = TLB.onRelease=function () { PSRS(-1);resizeMain(-1);};
	BRBN.onRelease=function () { PSRS(1);resizeMain(1);};
	BLB.onDragOut = TLB.onDragOut=function () { PSRS(-1);resizeMain(-1);}//PD = true;BRB._visible = TRB._visible=false;if (PFS) {FSO.start(0, 1);}};
	IBB.onDragOut = BRB.onDragOut = BRBN.onDragOut=function () { PSRS(1);resizeMain(1);}//PD = true;BLB._visible = TLB._visible=false;if (PFS) {FSO.start(0, 1);}};


	
	_parent.Pages._yscale=83.3
	_parent.Pages._y =550

	}

function resizeMain(num) {
	if (this.current_page==2.5 && num==1) {
		Tweener.addTween(_parent.Pages, {_xscale:70, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_yscale:70, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_xscale:83, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_yscale:83, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_y:490.75, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_y:536.75, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_x:240, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_x:250, time:0.4, delay:0.4, transition:"easeOutSine"});

		_root.p2frame=1
		_level0.Pages.FBP.Print.p2state.gotoAndPlay(2)
	} else if (this.current_page==0.5 && num==-1){
		Tweener.addTween(_parent.Pages, {_xscale:75, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_yscale:75, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_xscale:100, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_yscale:83.3, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_y:500, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_y:550, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_x:255, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_x:200, time:0.4, delay:0.4, transition:"easeOutSine",onComplete:collapse} );
	} else {
		Tweener.addTween(_parent.Pages, {_xscale:78, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_yscale:78, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_xscale:83, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_yscale:83, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_y:525, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_y:536.75, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_x:245, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_x:250, time:0.4, delay:0.4, transition:"easeOutSine"});
	}
	if (num==0) {
		Tweener.addTween(_parent.Pages, {_yscale:75, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_xscale:75, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_yscale:83.3, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_xscale:100, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_y:500, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_y:550, time:0.4, delay:0.4, transition:"easeOutSine"});
		Tweener.addTween(_parent.Pages, {_x:255, time:0.4, transition:"easeInSine"});
		Tweener.addTween(_parent.Pages, {_x:200, time:0.4, delay:0.4, transition:"easeOutSine", onComplete:collapse});
	}
	if (this.current_page>=num_of_pages) {

		BACK.PrintBack.btn.enabled=true
	} else {
		BACK.PrintBack.btn.enabled=false
	}
	}

function goBack() {

		this.createEmptyMovieClip("BACK", 1);
		with (BACK) {
			attachMovie("print7", "PrintBack", 1);
			with (PrintBack) {
				_x = page_width/2;
				_y = -VR*PY;
				btn.enabled=false
			}
		}
		_root.BACK._visible=false
		
	}