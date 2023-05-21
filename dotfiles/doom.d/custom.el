(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq user-full-name "Michael Bianchi"
      user-mail-address "michael@bianchi.dev")

(setq auto-save-default t)

(setq-default tab-width 2)

(map! :map elixir-mode-map
      :leader
      "mcb" #'alchemist-compile-this-buffer
      "meb" #'alchemist-execute-this-buffer)
