{:user {:plugins [[venantius/ultra "0.5.2"]
                  [jonase/eastwood "0.2.5" :exclusions [org.clojure/clojure]]]
        :dependencies [[pjstadig/humane-test-output "0.8.3"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
