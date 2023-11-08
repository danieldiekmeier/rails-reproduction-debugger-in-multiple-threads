# Reproduction

`binding.irb` inside system specs may get shown multiple times if multiple threads reach the breakpoint.

This is a brand new, vanilla Rails 7.1 app.

Run:

```sh
bin/setup
bin/rails server
```

Open `http://localhost:3000`. The page should make two fetch requests to two different controller actions and write "Finished" into the DOM.

Now run:

```sh
bin/rails test test/system/threadings_test.rb
```

and despair, because it should show two debuggers, like this:

```
From: /Users/daniel/dev/ruby/threading-repro/app/controllers/pages_controller.rb @ line 6 :

     1: class PagesController < ApplicationController
     2:   def index
     3:   end
     4:
     5:   def thread_one
 =>  6:     binding.irb if Rails.env.test?
     7:     render plain: 'This is plain text'
     8:   end
     9:
    10:   def thread_two
    11:     binding.irb if Rails.env.test?


From: /Users/daniel/dev/ruby/threading-repro/app/controllers/pages_controller.rb @ line 11 :

     6:     binding.irb if Rails.env.test?
     7:     render plain: 'This is plain text'
     8:   end
     9:
    10:   def thread_two
 => 11:     binding.irb if Rails.env.test?
    12:     render plain: 'This is plain text'
    13:   end
    14: end

irb(#<PagesController:0x000000010...):001>
```

This happens because Capybara starts Puma with multiple threads, and each thread can theoretically trigger a breakpoint.
