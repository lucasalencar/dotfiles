{:user {:plugins [[venantius/ultra "0.5.2"]
                  [jonase/eastwood "0.2.5" :exclusions [org.clojure/clojure]]
                  [jonase/kibit "0.1.6" :exclusions [org.clojure/clojure]]
                  [slamhound "1.5.5"]
                  [cider/cider-nrepl "0.16.0"]]
        :dependencies [[pjstadig/humane-test-output "0.8.3"]
                       [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]
                       [jonase/kibit "0.1.3" :exclusions [org.clojure/clojure]]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
