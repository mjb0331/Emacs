;;去掉Emacs启动界面
(setq inhibit-startup-message t)

(if window-system
    ;; (color-theme-sanityinc-solarized-dark)
    ;; (color-theme-sanityinc-tomorrow-bright)
    (color-theme-sanityinc-tomorrow-night)
  )
(provide 'init-themes)
