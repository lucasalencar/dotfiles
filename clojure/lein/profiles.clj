{:user {:plugins [[venantius/ultra "0.5.2"]
                  [jonase/eastwood "0.2.5" :exclusions [org.clojure/clojure]]
                  [jonase/kibit "0.1.6" :exclusions [org.clojure/clojure]]
                  [cider/cider-nrepl "0.16.0"]
                  [lein-cljfmt "0.5.7"]
                  [refactor-nrepl "2.4.0"]
                  [org.clojure/tools.nrepl "0.2.13" :exclusions [org.clojure/clojure]]]

        :dependencies [[pjstadig/humane-test-output "0.8.3"]
                       [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]
                       [jonase/kibit "0.1.3" :exclusions [org.clojure/clojure]]
                       [org.clojure/tools.nrepl "0.2.13" :exclusions [org.clojure/clojure]]]

        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
