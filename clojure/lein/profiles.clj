{:user
 {:plugins [[cider/cider-nrepl "0.21.1"]
            [lein-ancient "0.6.15"]
            [refactor-nrepl "2.4.0"]
            [nrepl "0.6.0"]]

  :dependencies [[clj-kondo "2019.05.26-alpha"]]

  :aliases {"clj-kondo" ["run" "-m" "clj-kondo.main"]}}}
