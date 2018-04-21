{:user {:plugins [[venantius/ultra "0.5.2"]
                  [jonase/eastwood "0.2.5" :exclusions [org.clojure/clojure]]
                  [cider/cider-nrepl "0.16.0"]]
        :dependencies [[pjstadig/humane-test-output "0.8.3"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
