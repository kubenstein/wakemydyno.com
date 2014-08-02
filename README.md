wakemydyno.com
=============

[wakemydyno.com](http://wakemydyno.com) is a service written in Rails, that will ping your heroku page every ~30mins preventing it from falling asleep.

 
Idea
-------
My imagination made me think about heroku dyno as a cute little animal, dinosaur, that just can't stay awake for too long.  

Interesting parts
-------
[wakemydyno.com](http://wakemydyno.com) is pretty simple Rails app with one model, one controller and few service objects.
Interesting and unusual part is that, the page runs web and background worker on same dyno.
Check `config/unicorn.rb` file.
