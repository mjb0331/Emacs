<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: vbs-repl.el</title><link rel="alternate" type="application/wiki" title="編輯本頁" href="http://www.emacswiki.org/emacs?action=edit;id=vbs-repl.el" />
<link type="text/css" rel="stylesheet" href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" />
<link type="text/css" rel="stylesheet" href="/css/bootstrap.css" />
<meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: vbs-repl.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=vbs-repl.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for vbs-repl.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=vbs-repl.el" /><meta name="viewport" content="width=device-width" />
<script type="text/javascript" src="/outliner.0.5.0.62-toc.js"></script>
<script type="text/javascript">

  function addOnloadEvent(fnc) {
    if ( typeof window.addEventListener != "undefined" )
      window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
      window.attachEvent( "onload", fnc );
    }
    else {
      if ( window.onload != null ) {
	var oldOnload = window.onload;
	window.onload = function ( e ) {
	  oldOnload( e );
	  window[fnc]();
	};
      }
      else
	window.onload = fnc;
    }
  }

  var initToc=function() {

    var outline = HTML5Outline(document.body);
    if (outline.sections.length == 1) {
      outline.sections = outline.sections[0].sections;
    }

    if (outline.sections.length > 1
	|| outline.sections.length == 1
           && outline.sections[0].sections.length > 0) {

      var toc = document.getElementById('toc');

      if (!toc) {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++) {
	  if (divs[i].getAttribute('class') == 'toc') {
	    toc = divs[i];
	    break;
	  }
	}
      }

      if (!toc) {
	var h2 = document.getElementsByTagName('h2')[0];
	if (h2) {
	  toc = document.createElement('div');
	  toc.setAttribute('class', 'toc');
	  h2.parentNode.insertBefore(toc, h2);
	}
      }

      if (toc) {
        var html = outline.asHTML(true);
        toc.innerHTML = html;
      }
    }
  }

  addOnloadEvent(initToc);
  </script>

<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
<script src="http://emacswiki.org/emacs/emacs-bootstrap.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="http://www.emacswiki.org/emacs"><div class="header"><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/%e7%b6%b2%e7%ab%99%e5%9c%b0%e5%9c%96">網站地圖</a> <a class="local" href="http://www.emacswiki.org/emacs/%e6%9c%80%e8%bf%91%e6%9b%b4%e6%96%b0">最近更新</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/%e6%95%99%e5%af%bc">教导</a> </span><h1><a title="按下即可以搜尋參考至本頁的資料" rel="nofollow" href="http://www.emacswiki.org/emacs?search=%22vbs-repl%5c.el%22">vbs-repl.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="download/vbs-repl.el">Download</a></p><pre class="code"><span class="linecomment">;;; vbs-repl.el --- Support for VBScript programming in Emacs</span>

<span class="linecomment">;;; Copyright: (C) 2009 Charles Sebold</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;     This program is NOT part of GNU Emacs.</span>
<span class="linecomment">;; </span>
<span class="linecomment">;;     This program is free software; you can redistribute it and/or</span>
<span class="linecomment">;;     modify it under the terms of the GNU General Public License as</span>
<span class="linecomment">;;     published by the Free Software Foundation; either version 2 of</span>
<span class="linecomment">;;     the License, or (at your option) any later version.</span>
<span class="linecomment">;;     </span>
<span class="linecomment">;;     This program is distributed in the hope that it will be useful,</span>
<span class="linecomment">;;     but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the</span>
<span class="linecomment">;;     GNU General Public License for more details.</span>
<span class="linecomment">;;     </span>
<span class="linecomment">;;     You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;;     along with GNU Emacs; if not, write to the Free Software</span>
<span class="linecomment">;;     Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA</span>
<span class="linecomment">;;     02110-1301 USA</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Latest version should be available at:</span>
<span class="linecomment">;;     &lt;URL:http://www.emacswiki.org/emacs/VbsReplMode&gt;</span>
<span class="linecomment">;;</span>

<span class="linecomment">;; Filename: vbs-repl.el</span>
<span class="linecomment">;; Description: Support for VBScript programming in Emacs</span>
<span class="linecomment">;; Author: Charles Sebold &lt;csebold at gmail.com&gt;</span>
<span class="linecomment">;; Maintainer: Charles Sebold &lt;csebold at gmail.com&gt;</span>
<span class="linecomment">;; Created: Thu 19 Feb 2009 10:00</span>
<span class="linecomment">;; Version: 2.1</span>
<span class="linecomment">;; Last-Updated: Fri 20 Feb 2009 17:01</span>
<span class="linecomment">;;           By: Charles Sebold</span>
<span class="linecomment">;;     Update #: 1</span>
<span class="linecomment">;; URL: http://www.emacswiki.org/emacs/VbsReplMode</span>
<span class="linecomment">;; Keywords: vbscript, repl, programming, mode</span>
<span class="linecomment">;; Compatibility: GNU Emacs 22+, untested with Emacs21- or XEmacs</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; Features that might be required by this library:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;;   visual-basic-mode.el &lt;http://www.emacswiki.org/emacs/VisualBasicMode&gt;</span>

<span class="linecomment">;;; Commentary:</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; At this point, there are a few different forks of visual basic modes</span>
<span class="linecomment">;; to choose from, if you want to develop VBScript.  The hard thing</span>
<span class="linecomment">;; about scripting in VBScript (especially if you're more accustomed to</span>
<span class="linecomment">;; Lispy sorts of languages) is the lack of a REPL</span>
<span class="linecomment">;; (Read-Eval-Print-Loop), a way to try things and see if they work.</span>
<span class="linecomment">;; The aim of this Emacs package is to provide functionality similar to</span>
<span class="linecomment">;; a REPL, although it won't really be one.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; The biggest thing holding me back from making this a full-blown REPL</span>
<span class="linecomment">;; is the painful truth that VBScript's "=" operator is ambiguous by</span>
<span class="linecomment">;; itself; it needs context.  For example, do you want to assign the</span>
<span class="linecomment">;; value 5 to the variable x?  Then you can say "x=5" and there, you</span>
<span class="linecomment">;; have assigned that value.  But how do you test for equality between x</span>
<span class="linecomment">;; and 5?  The same way.  In the context of things like If...Then</span>
<span class="linecomment">;; statements, If x=5 Then... will not assign 5 to x, it will test for</span>
<span class="linecomment">;; equality between x and 5.  Hence, just like the difference between</span>
<span class="linecomment">;; Subs and Functions, there are two ways of evaluating a string into</span>
<span class="linecomment">;; VBScript code: Execute (corresponds to Sub), and Eval (corresponds to</span>
<span class="linecomment">;; Function).</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; For the purposes of this code, by default everything is an Execute.</span>
<span class="linecomment">;; If you want something to be Evaled rather than Executed, run it with</span>
<span class="linecomment">;; the prefix argument.  For example, if I'm sitting with the cursor at</span>
<span class="linecomment">;; the end of a variable assignment, like "x = 5", with my keybindings</span>
<span class="linecomment">;; I'll hit C-c C-e to execute that line.  But if I want to know if x =</span>
<span class="linecomment">;; 5, then I'll use the prefix arg.  In that case, I hit C-u C-c C-e,</span>
<span class="linecomment">;; and I get either "True" or "False" in response.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Previous versions of this REPL tried to guess whether you wanted code</span>
<span class="linecomment">;; Evaled or Executed.  That was too problematic; maybe in the future we</span>
<span class="linecomment">;; will do that again, but for now you can guide it to do what you want.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; New in this version: we have a vbscript-mode now, derived from</span>
<span class="linecomment">;; visual-basic-mode.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; To use this, put it in your load-path and do something like the</span>
<span class="linecomment">;; following in your .emacs file:</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; ; VBScript editing</span>
<span class="linecomment">;; (setq auto-mode-alist</span>
<span class="linecomment">;;       (append '(("\\.\\(vbs\\|wsf\\)$" . vbscript-mode))</span>
<span class="linecomment">;;               auto-mode-alist))</span>
<span class="linecomment">;; </span>
<span class="linecomment">;; To start the repl, load a VBScript file, make sure you're in</span>
<span class="linecomment">;; visual-basic mode, and hit C-c C-z (or whatever you mapped to</span>
<span class="linecomment">;; vbs-setup-repl).  To execute from the beginning of the line (or the</span>
<span class="linecomment">;; beginning of the statement; it does recognize multiline VBScript),</span>
<span class="linecomment">;; use C-c C-e.  Select a region and execute it with C-c C-r.  If you</span>
<span class="linecomment">;; want it to Eval rather than Execute (like, for example, you want to</span>
<span class="linecomment">;; know what "x & y" would be), Use C-u before the above keystrokes.</span>

<span class="linecomment">;;; History:</span>
<span class="linecomment">;; </span>
<span class="linecomment">;;  v1.0: implemented a REPL that tried to guess whether you wanted your</span>
<span class="linecomment">;;        code Evaled or Executed</span>
<span class="linecomment">;;  v2.0: new REPL, easier to run without Emacs, now defaults to</span>
<span class="linecomment">;;        Executing everything but you decide when you want it Evaled</span>
<span class="linecomment">;;  v2.1: Implemented `vbscript-mode' derived from visual-basic-mode</span>

<span class="linecomment">;;; Code:</span>

(defvar vbs-repl-script "<span class="quote">ReplPrompt = \"&gt; \"
Set ReplFso = CreateObject(\"Scripting.FileSystemObject\")

Sub ReplErrprint(errno)
    WScript.StdOut.Write \"Error # \" & CStr(errno.Number) & \" \" & _
        errno.Description
End Sub

Function ReplWhyMulti(firstLine)
    If Right(firstLine,1) = \"_\" Then
        ReplWhyMulti = \"_\"
    Elseif LCase(Left(firstLine,3)) = \"sub\" Then
        ReplWhyMulti = \"Sub\"
    Elseif LCase(Left(firstLine,8)) = \"function\" Then
        ReplWhyMulti = \"Function\"
    Else
        ReplWhyMulti = \"?\"
    End If
End Function

Function ReplTestEndMulti(lastLine,why)
    lastLine = LTrim(RTrim(lastLine))
    If why = \"_\" And Right(lastLine,1) &lt;&gt; \"_\" Then
        ReplTestEndMulti = True
    Elseif why = \"Sub\" And LCase(lastLine) = \"end sub\" Then
        ReplTestEndMulti = True
    Elseif why = \"Function\" And LCase(lastline) = \"end function\" Then
        ReplTestEndMulti = True
    Else
        ReplTestEndMulti = False
    End If
End Function

Function ReplBufferIn(firstLine)
    firstLine = LTrim(RTrim(firstLine))
    ReplWhy = ReplWhyMulti(firstLine)
    ReplPrompt = ReplWhy & \"&gt; \"
    ReplBufferIn = firstLine
    Do
        WScript.StdOut.Write ReplPrompt
        nextLine = WScript.StdIn.ReadLine
        ReplBufferIn = ReplBufferIn & vbCRLF & nextLine
    Loop Until ReplTestEndMulti(nextLine, ReplWhy)
    ReplPrompt = \"&gt; \"
End Function

While 1:
    WScript.StdOut.Write ReplPrompt
    ReplInput = WScript.StdIn.ReadLine
    If ReplInput &lt;&gt; \"\" Then
        If ReplWhyMulti(ReplInput) &lt;&gt; \"?\" Then
            ReplInput = ReplBufferIn(ReplInput)
            On Error Resume Next
            Execute(ReplInput)
        Else
            ReplInputArgs = Split(LTrim(ReplInput))
            If ReplInputArgs(0) = \"ReplLoad\" Then
                Set ReplFile = ReplFso.OpenTextFile(ReplInputArgs(1), 1)
                ReplInput = \"\"
                Do While ReplFile.AtEndOfStream &lt;&gt; True
                    ReplThisLine = ReplFile.ReadLine
                    ReplInput = ReplInput & ReplThisLine & vbCRLF
                Loop
                ReplFile.Close()
                On Error Resume Next
                Execute(ReplInput)
            Elseif ReplInputArgs(0) = \"ReplLoadEval\" Then
                Set ReplFile = ReplFso.OpenTextFile(ReplInputArgs(1), 1)
                ReplInput = \"\"
                Do While ReplFile.AtEndOfStream &lt;&gt; True
                    ReplThisLine = ReplFile.ReadLine
                    ReplInput = ReplInput & ReplThisLine & vbCRLF
                Loop
                ReplFile.Close()
                On Error Resume Next
                WScript.StdOut.Write Eval(ReplInput) & vbCRLF
            Elseif ReplInputArgs(0) = \"ReplEval\" Then
                On Error Resume Next
                WScript.StdOut.Write Eval(Right(ReplInput,Len(ReplInput)-9)) & _
                       vbCRLF
            Else
                On Error Resume Next
                Execute(ReplInput)
            End If
        End If
        If Err.Number &lt;&gt; 0 Then
            ReplErrprint(Err)
            WScript.StdOut.Write vbCRLF
            Err.Clear
        End If
    End If
    On Error GoTo 0
Wend
</span>")

(defun vbs-run-repl ()
  "<span class="quote">Deletes all tempfiles and run a new REPL.</span>"
  (interactive)
  (dolist (i (directory-files temporary-file-directory t
                              "<span class="quote">vbsrepl.*\\.vbs</span>"))
    (delete-file i))
  (let ((tempfile (make-temp-file "<span class="quote">vbsrepl</span>" nil "<span class="quote">.vbs</span>")))
    (with-temp-file tempfile
      (insert vbs-repl-script))
    (make-comint "<span class="quote">VBScript</span>" "<span class="quote">cscript</span>" nil tempfile)))

(defun vbs-setup-repl ()
  "<span class="quote">Set up a REPL in the opposite window, restarting it if necessary.</span>"
  (interactive)
  (delete-other-windows)
  (if (&gt; (frame-parameter nil 'width) 160)
      (split-window-horizontally)
    (split-window-vertically))
  (other-window 1)
  (if (and (get-buffer "<span class="quote">*VBScript*</span>") (get-process "<span class="quote">VBScript</span>"))
      (switch-to-buffer "<span class="quote">*VBScript*</span>")
    (vbs-run-repl)
    (switch-to-buffer "<span class="quote">*VBScript*</span>"))
  (other-window 1))

(defun vbs-execute-expression (arg evalp)
  "<span class="quote">Send expression to REPL and evaluate it.
Argument ARG is the prefix argument.
Argument EVALP is whether to sent this to Eval (nil) or Execute (t).</span>"
  (if evalp
      (if (string-match "<span class="quote">\n</span>" arg)
          (let ((tempfile (make-temp-file "<span class="quote">vbsrepl</span>" nil "<span class="quote">.vbs</span>")))
            (with-temp-file tempfile
              (insert arg))
            (comint-send-string "<span class="quote">*VBScript*</span>"
                                (concat "<span class="quote">ReplLoadEval </span>" tempfile "<span class="quote">\n</span>")))
        (comint-send-string "<span class="quote">*VBScript*</span>" (concat "<span class="quote">ReplEval </span>" arg "<span class="quote">\n</span>")))
    (if (string-match "<span class="quote">\n</span>" arg)
        (let ((tempfile (make-temp-file "<span class="quote">vbsrepl</span>" nil "<span class="quote">.vbs</span>")))
          (with-temp-file tempfile
            (insert arg))
          (comint-send-string "<span class="quote">*VBScript*</span>"
                              (concat "<span class="quote">ReplLoad </span>" tempfile "<span class="quote">\n</span>")))
      (comint-send-string "<span class="quote">*VBScript*</span>" (concat arg "<span class="quote">\n</span>")))))

(defun vbs-last-exp (arg)
  "<span class="quote">Return last expression in current buffer before ARG.</span>"
  (let ((beginning-pt
         (let ((possible (save-excursion
                           (beginning-of-line)
                           (point))))
           (if (= possible (point-min))
               possible
             (save-excursion
               (while
                   (progn
                     (forward-line -1)
                     (beginning-of-line)
                     (and (not (= (point) (point-min)))
                          (looking-at "<span class="quote">[^\n]*?_ *\n</span>"))))
               (if (and (= (point) (point-min))
                        (looking-at "<span class="quote">[^\n]*?_ *\n</span>"))
                   (point)
                 (forward-line 1)
                 (point)))))))
    (buffer-substring-no-properties beginning-pt arg)))

(defun vbs-execute-sub ()
  "<span class="quote">When within a Sub or Function definition, Execute it.</span>"
  (interactive)
  (save-excursion
    (let* ((current (point))
           (end (progn
                  (beginning-of-line)
                  (re-search-forward "<span class="quote">^ *end \\(sub\\|function\\)</span>" nil t)
                  (point)))
           (s-or-f (match-string-no-properties 1))
           (start (progn
                    (re-search-backward
                     (concat "<span class="quote">^ *</span>" s-or-f "<span class="quote"> </span>") nil t)
                    (point))))
      (if (&gt; start current)
          (message "<span class="quote">Not in a sub or function.</span>")
        (vbs-execute-expression
         (buffer-substring-no-properties start end)
         nil)))))

(defun vbs-execute-region (start end)
  "<span class="quote">Send region from START to END to REPL.</span>"
  (interactive "<span class="quote">r</span>")
  (vbs-execute-expression
   (buffer-substring-no-properties start end)
   current-prefix-arg))

(defun vbs-execute (arg)
  "<span class="quote">Evaluate VBScript expression before point.
Argument ARG is the prefix arg, add prefix if you want this Evaled
rather than Executed.</span>"
  (interactive "<span class="quote">P</span>")
  (let ((eval-this (vbs-last-exp (point))))
    (if eval-this
        (vbs-execute-expression eval-this arg)
      (message "<span class="quote">Unable to find last expression.</span>"))))

(require 'visual-basic-mode)

<span class="linecomment">;; This is some approximation of the set of reserved words in VBScript.</span>
(eval-and-compile
  (defvar vbscript-all-keywords
    '("<span class="quote">Abs</span>" "<span class="quote">And</span>" "<span class="quote">Array</span>" "<span class="quote">Asc</span>" "<span class="quote">AscB</span>" "<span class="quote">AscW</span>" "<span class="quote">Assignments</span>" "<span class="quote">Atn</span>"
      "<span class="quote">CBool</span>" "<span class="quote">CByte</span>" "<span class="quote">CCur</span>" "<span class="quote">CDate</span>" "<span class="quote">CDbl</span>" "<span class="quote">CInt</span>" "<span class="quote">CLng</span>" "<span class="quote">CSng</span>" "<span class="quote">CStr</span>"
      "<span class="quote">Call</span>" "<span class="quote">Case</span>" "<span class="quote">Chr</span>" "<span class="quote">ChrB</span>" "<span class="quote">ChrW</span>" "<span class="quote">Cint</span>" "<span class="quote">Class</span>" "<span class="quote">Clear</span>" "<span class="quote">Const</span>"
      "<span class="quote">Conversions</span>" "<span class="quote">Cos</span>" "<span class="quote">CreateObject</span>" "<span class="quote">Date</span>" "<span class="quote">DateAdd</span>" "<span class="quote">DateDiff</span>"
      "<span class="quote">DatePart</span>" "<span class="quote">DateSerial</span>" "<span class="quote">DateValue</span>" "<span class="quote">Day</span>" "<span class="quote">Derived</span>" "<span class="quote">Description</span>"
      "<span class="quote">Dim</span>" "<span class="quote">Do</span>" "<span class="quote">Each</span>" "<span class="quote">Else</span>" "<span class="quote">ElseIf</span>" "<span class="quote">Empty</span>" "<span class="quote">End</span>" "<span class="quote">Eqv</span>" "<span class="quote">Erase</span>" "<span class="quote">Err</span>"
      "<span class="quote">Error</span>" "<span class="quote">Eval</span>" "<span class="quote">Execute</span>" "<span class="quote">ExecuteGlobal</span>" "<span class="quote">Exit</span>" "<span class="quote">Exp</span>" "<span class="quote">Explicit</span>"
      "<span class="quote">False</span>" "<span class="quote">Filter</span>" "<span class="quote">FirstIndex</span>" "<span class="quote">Fix</span>" "<span class="quote">Fixs</span>" "<span class="quote">For</span>" "<span class="quote">FormatCurrency</span>"
      "<span class="quote">FormatDateTime</span>" "<span class="quote">FormatNumber</span>" "<span class="quote">FormatPercent</span>" "<span class="quote">Function</span>" "<span class="quote">GetLocale</span>"
      "<span class="quote">GetObject</span>" "<span class="quote">GetRef</span>" "<span class="quote">Global</span>" "<span class="quote">HelpContext</span>" "<span class="quote">HelpFile</span>" "<span class="quote">Hex</span>" "<span class="quote">Hour</span>"
      "<span class="quote">If</span>" "<span class="quote">IgnoreCase</span>" "<span class="quote">Imp</span>" "<span class="quote">InStr</span>" "<span class="quote">InStrB</span>" "<span class="quote">InStrRev</span>" "<span class="quote">InputBox</span>" "<span class="quote">Instr</span>"
      "<span class="quote">Int</span>" "<span class="quote">Int,</span>" "<span class="quote">Is</span>" "<span class="quote">IsArray</span>" "<span class="quote">IsArray </span>" "<span class="quote">IsDate</span>" "<span class="quote">IsEmpty</span>" "<span class="quote">IsNull</span>"
      "<span class="quote">IsNumeric</span>" "<span class="quote">IsObject</span>" "<span class="quote">Join</span>" "<span class="quote">LBound</span>" "<span class="quote">LCase</span>" "<span class="quote">LTrim</span>" "<span class="quote">Lcase</span>" "<span class="quote">Left</span>"
      "<span class="quote">LeftB</span>" "<span class="quote">Len</span>" "<span class="quote">LenB</span>" "<span class="quote">Length</span>" "<span class="quote">Let</span>" "<span class="quote">LoadPicture</span>" "<span class="quote">Log</span>" "<span class="quote">Loop</span>" "<span class="quote">Ltrim</span>"
      "<span class="quote">Match</span>" "<span class="quote">Math</span>" "<span class="quote">Maths</span>" "<span class="quote">Mid</span>" "<span class="quote">MidB</span>" "<span class="quote">Minute</span>" "<span class="quote">Mod</span>" "<span class="quote">Month</span>" "<span class="quote">MonthName</span>"
      "<span class="quote">MsgBox</span>" "<span class="quote">New</span>" "<span class="quote">Next</span>" "<span class="quote">Not</span>" "<span class="quote">Nothing</span>" "<span class="quote">Now</span>" "<span class="quote">Null</span>" "<span class="quote">Number</span>" "<span class="quote">Oct</span>" "<span class="quote">On</span>"
      "<span class="quote">Option</span>" "<span class="quote">Or</span>" "<span class="quote">Pattern</span>" "<span class="quote">Private</span>" "<span class="quote">Procedures</span>" "<span class="quote">Public</span>" "<span class="quote">RGB</span>" "<span class="quote">RTrim</span>"
      "<span class="quote">Raise</span>" "<span class="quote">Randomize</span>" "<span class="quote">ReDim</span>" "<span class="quote">Rem</span>" "<span class="quote">Replace</span>" "<span class="quote">Right</span>" "<span class="quote">RightB</span>" "<span class="quote">Rnd</span>"
      "<span class="quote">Round</span>" "<span class="quote">Rtrim</span>" "<span class="quote">ScriptEngine</span>" "<span class="quote">ScriptEngineBuildVersion</span>"
      "<span class="quote">ScriptEngineMajorVersion</span>" "<span class="quote">ScriptEngineMinorVersion</span>" "<span class="quote">Second</span>"
      "<span class="quote">Select</span>" "<span class="quote">Set</span>" "<span class="quote">SetLocale</span>" "<span class="quote">Sgn</span>" "<span class="quote">Sin</span>" "<span class="quote">Source</span>" "<span class="quote">Space</span>" "<span class="quote">Split</span>" "<span class="quote">Sqr</span>"
      "<span class="quote">StrComp</span>" "<span class="quote">String</span>" "<span class="quote">Strings</span>" "<span class="quote">Sub</span>" "<span class="quote">SubMatches</span>" "<span class="quote">Tan</span>" "<span class="quote">Test</span>" "<span class="quote">Then</span>"
      "<span class="quote">Time</span>" "<span class="quote">TimeSerial</span>" "<span class="quote">TimeValue</span>" "<span class="quote">Timer</span>" "<span class="quote">Trim</span>" "<span class="quote">Trims</span>" "<span class="quote">True</span>"
      "<span class="quote">TypeName</span>" "<span class="quote">UBound</span>" "<span class="quote">UCase</span>" "<span class="quote">Ucase</span>" "<span class="quote">Until</span>" "<span class="quote">Value</span>" "<span class="quote">VarType</span>"
      "<span class="quote">Variants</span>" "<span class="quote">VbCrLf</span>" "<span class="quote">Weekday</span>" "<span class="quote">WeekdayName</span>" "<span class="quote">Wend</span>" "<span class="quote">While</span>" "<span class="quote">With</span>"
      "<span class="quote">Xor</span>" "<span class="quote">Year</span>" "<span class="quote">vbAbort</span>" "<span class="quote">vbAbortRetryIgnore</span>" "<span class="quote">vbApplicationModal</span>"
      "<span class="quote">vbArray</span>" "<span class="quote">vbBinaryCompare</span>" "<span class="quote">vbBlack</span>" "<span class="quote">vbBlue</span>" "<span class="quote">vbBoolean</span>" "<span class="quote">vbByte</span>"
      "<span class="quote">vbCancel</span>" "<span class="quote">vbCr</span>" "<span class="quote">vbCritical</span>" "<span class="quote">vbCurrency</span>" "<span class="quote">vbCyan</span>" "<span class="quote">vbDataObject</span>"
      "<span class="quote">vbDate</span>" "<span class="quote">vbDecimal</span>" "<span class="quote">vbDefaultButton1</span>" "<span class="quote">vbDefaultButton2</span>"
      "<span class="quote">vbDefaultButton3</span>" "<span class="quote">vbDefaultButton4</span>" "<span class="quote">vbEmpty</span>" "<span class="quote">vbError</span>"
      "<span class="quote">vbExclamation</span>" "<span class="quote">vbFalse</span>" "<span class="quote">vbFirstFourDays</span>" "<span class="quote">vbFirstFullWeek</span>"
      "<span class="quote">vbFirstJan1</span>" "<span class="quote">vbFormFeed</span>" "<span class="quote">vbFriday</span>" "<span class="quote">vbGeneralDate</span>" "<span class="quote">vbGreen</span>"
      "<span class="quote">vbIgnore</span>" "<span class="quote">vbInformation</span>" "<span class="quote">vbInteger</span>" "<span class="quote">vbLf</span>" "<span class="quote">vbLong</span>" "<span class="quote">vbLongDate</span>"
      "<span class="quote">vbLongTime</span>" "<span class="quote">vbMagenta</span>" "<span class="quote">vbMonday</span>" "<span class="quote">vbNewLine</span>" "<span class="quote">vbNo</span>" "<span class="quote">vbNull</span>"
      "<span class="quote">vbNullChar</span>" "<span class="quote">vbNullString</span>" "<span class="quote">vbOK</span>" "<span class="quote">vbOKCancel</span>" "<span class="quote">vbOKOnly</span>" "<span class="quote">vbObject</span>"
      "<span class="quote">vbObjectError</span>" "<span class="quote">vbQuestion</span>" "<span class="quote">vbRed</span>" "<span class="quote">vbRetry</span>" "<span class="quote">vbRetryCancel</span>"
      "<span class="quote">vbSaturday</span>" "<span class="quote">vbShortDate</span>" "<span class="quote">vbShortTime</span>" "<span class="quote">vbSingle</span>" "<span class="quote">vbString</span>"
      "<span class="quote">vbSunday</span>" "<span class="quote">vbSystemModal</span>" "<span class="quote">vbTab</span>" "<span class="quote">vbTextCompare</span>" "<span class="quote">vbThursday</span>"
      "<span class="quote">vbTrue</span>" "<span class="quote">vbTuesday</span>" "<span class="quote">vbUseDefault</span>" "<span class="quote">vbUseSystemDayOfWeek</span>" "<span class="quote">vbVariant</span>"
      "<span class="quote">vbVerticalTab</span>" "<span class="quote">vbWednesday</span>" "<span class="quote">vbWhite</span>" "<span class="quote">vbYellow</span>" "<span class="quote">vbYes</span>" "<span class="quote">vbYesNo</span>"
      "<span class="quote">vbYesNoCancel</span>")))

(defvar vbscript-font-lock-keywords-1
  (eval-when-compile
    (list
     <span class="linecomment">;; Names of functions.</span>
     (list visual-basic-defun-start-regexp
           '(1 font-lock-keyword-face nil t)
           '(2 font-lock-keyword-face nil t)
           '(3 font-lock-function-name-face))

     <span class="linecomment">;; Statement labels</span>
     (cons visual-basic-label-regexp 'font-lock-keyword-face)

     <span class="linecomment">;; Case values</span>
     <span class="linecomment">;; String-valued cases get font-lock-string-face regardless.</span>
     (list "<span class="quote">^[ \t]*case[ \t]+\\([^'\n]+\\)</span>" 1 'font-lock-keyword-face t)

     <span class="linecomment">;; Any keywords you like.</span>
     (list (regexp-opt
            '("<span class="quote">Dim</span>" "<span class="quote">If</span>" "<span class="quote">Then</span>" "<span class="quote">Else</span>" "<span class="quote">ElseIf</span>" "<span class="quote">End If</span>") 'words)
           1 'font-lock-keyword-face))))

(defvar vbscript-font-lock-keywords-2
  (append vbscript-font-lock-keywords-1
          (eval-when-compile
            `((, (regexp-opt vbscript-all-keywords 'words)
                   1 font-lock-keyword-face)))))

(defvar vbscript-font-lock-keywords vbscript-font-lock-keywords-1)

(define-derived-mode vbscript-mode visual-basic-mode "<span class="quote">VBScript</span>"
  "<span class="quote">Major mode for VBScript.
\\{vbscript-mode-map}</span>"
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        `((vbscript-font-lock-keywords
           vbscript-font-lock-keywords-1
           vbscript-font-lock-keywords-2)
          nil t ((,(string-to-char "<span class="quote">_</span>") . "<span class="quote">w</span>")))))

(define-key vbscript-mode-map "<span class="quote">\C-c\C-z</span>" 'vbs-setup-repl)
(define-key vbscript-mode-map "<span class="quote">\C-c\C-e</span>" 'vbs-execute)
(define-key vbscript-mode-map "<span class="quote">\C-c\C-r</span>" 'vbs-execute-region)
(define-key vbscript-mode-map "<span class="quote">\C-\M-x</span>" 'vbs-execute-sub)

(provide 'vbs-repl)
(provide 'vbs-repl)

<span class="linecomment">;;; vbs-repl.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/%e7%b6%b2%e7%ab%99%e5%9c%b0%e5%9c%96">網站地圖</a> <a class="local" href="http://www.emacswiki.org/emacs/%e6%9c%80%e8%bf%91%e6%9b%b4%e6%96%b0">最近更新</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/%e6%95%99%e5%af%bc">教导</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=vbs-repl.el;missing=de_en_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="comment local edit" accesskey="c" href="http://www.emacswiki.org/emacs/Comments_on_vbs-repl.el">讨论</a> <a class="edit" accesskey="e" title="按此即可編輯此頁面" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=vbs-repl.el">編輯本頁</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=vbs-repl.el">參閱其他版本</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=vbs-repl.el">管理 Oddmuse</a></span><span class="time"><br /> 最後編輯於 2009-02-20 23:08 UTC 由 97-92-226-127.dhcp.stls.mo.charter.com <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=vbs-repl.el">(比較差異)</a></span><form method="get" action="http://www.emacswiki.org/cgi-bin/emacs" enctype="multipart/form-data" accept-charset="utf-8" class="search">
<p><label for="search">搜尋：</label> <input type="text" name="search"  size="20" accesskey="f" id="search" /> <label for="searchlang">語文：</label> <input type="text" name="lang"  size="10" id="searchlang" /> <input type="submit" name="dosearch" value="開始！" /></p></form><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a class="licence" href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
