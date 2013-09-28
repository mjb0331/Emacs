(defun c-wx-lineup-topmost-intro-cont (langelem)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "EVT_" (line-end-position) t)
	'c-basic-offset
      (c-lineup-topmost-intro-cont langelem))))
(defconst my-c-style
  '(
     (c-style-variables-are-local-p . nil)
     (c-label-minimum-indentation . 0)
     (indent-tabs-mode . nil)
     (c-tab-always-indent . nil)
     (c-auto-newline . nil)
     (c-basic-offset . 4)
     (c-comment-only-line-offset . (0 . 0))
     (c-hanging-braces-alist     . ((substatement-open before after)
				    (arglist-cont-nonempty)))
     (c-offsets-alist . ((defun-block-intro . +)     ;函数内的第一条语句
			 (statement-cont . +)        ;上一句不完整statement的继续
			 (statement-block-intro . +) ;函数内部的一些if for 等语句的open 第一条语句
			 (knr-argdecl-intro . +)     ;K&R C语言参数声明的第一行
			 (substatement-open . 0)     ;函数中if,for等语言块的开始的大括号
			 (substatement-label . +)    ;The first line after a conditional or loop construct if it's a label
			 (label . 0)                 ;Any other label
			 (statement-case-open . +)   ;case开始大括号
			 (arglist-intro . c-lineup-arglist-intro-after-paren)    ;第一个参数
			 (arglist-close . c-lineup-arglist)   ;参数的结束括号
			 (inline-open . 0)           ;类里面内联的开始的括号
			 (brace-list-open . +)       ;枚举和静态变量列表开始的括号
			 (inextern-lang . 0)
			 (topmost-intro . 0)         ;top-level 表达示的第一行
			 (topmost-intro-cont         ;是topmost-intro 的continuation(继续)
			  . (first c-lineup-topmost-intro-cont
				   c-lineup-gnu-DEFUN-intro-cont))))
     (c-special-indent-hook . c-gnu-impose-minimum)
     (c-block-comment-prefix . ""))
     "my-c-style"
  )
(c-add-style "my-c-style" my-c-style)

;C/C++ SECTION
(defun my-c-mode-hook ()
  (local-set-key "\M-f" 'c-forward-into-nomenclature)
  (local-set-key "\M-b" 'c-backward-into-nomenclature)
  (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include" "$WXWIN/include"))

  (local-set-key "\C-m" 'newline-and-indent)
  (c-set-style "my-c-style")
  ;syntax-highlight aggressively
  ;(setq font-lock-support-mode 'lazy-lock-mode)
  ;(setq lazy-lock-defer-contextually t)
  ;(setq lazy-lock-defer-time 0)

  ;make DEL take all previous whitespace with it
  ;(c-toggle-hungry-state 1)
  ;make a #define be left-aligned
  ;(setq c-electric-pound-behavior (quote (alignleft)))

  ;(gtags-mode 1)

  ; @see https://github.com/seanfisk/cmake-flymake
  ; make sure you project use cmake
  ;(flymake-mode)

  )
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(provide 'init-cc-mode)
