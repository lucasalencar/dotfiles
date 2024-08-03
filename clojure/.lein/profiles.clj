{:user
 {:plugins [[cider/cider-nrepl "0.25.9"]
            [lein-ancient "0.7.0"]
            [refactor-nrepl "2.5.1"]
            [nrepl "0.8.3"]]

  :dependencies [[clj-kondo "2019.05.26-alpha"]]

  :aliases {"clj-kondo" ["run" "-m" "clj-kondo.main"]}}}
