if (!('boxShadow' in document.body.style)) {
	document.body.setAttribute('class', 'noBoxShadow');
}

document.body.addEventListener("click", function(e) {
	var target = e.target;
	if (target.tagName === "INPUT" &&
		target.getAttribute('class').indexOf('liga') === -1) {
		target.select();
	}
});

(function() {
	var fontSize = document.getElementById('fontSize'),
		testDrive = document.getElementById('testDrive'),
		testText = document.getElementById('testText');
	var fontSizeRev = document.getElementById('fontSizeRev'),
		testDriveRev = document.getElementById('testDriveRev'),
		testTextRev = document.getElementById('testTextRev');
	function updateTest() {
		testDrive.innerHTML = testText.value || String.fromCharCode(160);
		if (window.icomoonLiga) {
			window.icomoonLiga(testDrive);
		}
	}
	function updateTestRev() {
		testDriveRev.innerHTML = testTextRev.value || String.fromCharCode(160);
		if (window.icomoonLiga) {
			window.icomoonLiga(testDriveRev);
		}
	}
	function updateSize() {
		testDrive.style.fontSize = fontSize.value + 'px';
	}
	function updateSizeRev() {
		testDriveRev.style.fontSize = fontSizeRev.value + 'px';
	}
	fontSize.addEventListener('change', updateSize, false);
	testText.addEventListener('input', updateTest, false);
	testText.addEventListener('change', updateTest, false);
	fontSizeRev.addEventListener('change', updateSizeRev, false);
	testTextRev.addEventListener('input', updateTestRev, false);
	testTextRev.addEventListener('change', updateTestRev, false);
	updateSize();
	updateSizeRev();
}());
