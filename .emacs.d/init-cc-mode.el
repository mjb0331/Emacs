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
     (c-offsets-alist . ((defun-block-intro . +)     ;�����ڵĵ�һ�����
			 (statement-cont . +)        ;��һ�䲻����statement�ļ���
			 (statement-block-intro . +) ;�����ڲ���һЩif for ������open ��һ�����
			 (knr-argdecl-intro . +)     ;K&R C���Բ��������ĵ�һ��
			 (substatement-open . 0)     ;������if,for�����Կ�Ŀ�ʼ�Ĵ�����
			 (substatement-label . +)    ;The first line after a conditional or loop construct if it's a label
			 (label . 0)                 ;Any other label
			 (statement-case-open . +)   ;case��ʼ������
			 (arglist-intro . c-lineup-arglist-intro-after-paren)    ;��һ������
			 (arglist-close . c-lineup-arglist)   ;�����Ľ�������
			 (inline-open . 0)           ;�����������Ŀ�ʼ������
			 (brace-list-open . +)       ;ö�ٺ;�̬�����б�ʼ������
			 (inextern-lang . 0)
			 (topmost-intro . 0)         ;top-level ���ʾ�ĵ�һ��
			 (topmost-intro-cont         ;��topmost-intro ��continuation(����)
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
