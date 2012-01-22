Description for the Impatient
-----------------------------

Word Cloud is a Ruby project for taking a YAML file of words and dumping them into Wordle so you can generate a
word cloud picture.  Simply clone the repo on GitHub, run `bundle install` from the command line, then
`rake generate_wordle`.
  
  
***  

History/Background
------------------

Here is a handy little project for generating word clouds using the website at [wordle.net](http://wordle.net).  Specifically I
wrote this to generate the T-Shirt for the Test Automation Bazaar conference that I am helping plan.  Ideally,
I would have just pointed some tool at some mailing list and had a tool do all the work for me, but AFAIK there
isn't one of these out there that I could find ... at least in 10 minutes of searching.

Wordle is a pretty cool site, and I found that I could generate the list I was wanting by feeding it a ":"
separated file.  After fiddling I found that I could use a YAML file to make tweaking the weights of the words easier.
So, what you have is an afternoon of fiddling that resulted in a super-nerdy way to generate word clouds.

For the [Test Automation Bazaar](http://watir.com/category/test-automation-bazaar/)
-----------------------------------------------------------------------------------

If you are coming here because you saw this on the mailing list, great!  Please add some more words to: `\lib\word_cloud\data.yaml`
that you feel represent test automation, specifically the community that will be at the conference.  This will make
collaborating on a design easier for me as I can just get a YAML file or have somebody `git push` their changes to me.

Please leave the value of "Test Automation Baazar" set to 100 and don't use weights greater than 80.  That
way the conference name is displayed prominently.  Also, I thought it would be cool to hide some geek jokes
in the logo, so I have them set at a weight of 10.  Any lower and I don't think they would come out right
on the T-Shirt.

You can control how Wordle generates the picture.  The Font drop down menu lets you change the fonts.  So far
my favorites are: *ExpresswayFree*, *Telephoto*, and *Teen*.  I normally use the *Blue Meets Orange* color scheme under
Color and I feel like *Mostly Horizontal* as a Layout will work best on a T-Shirt.

Here are my favorite 3 so far:  
[Cloud 1](http://www.wordle.net/show/wrdl/4707634/Test_Automation_Bazaar_2012)  
[Cloud 2](http://www.wordle.net/show/wrdl/4707961/Test_Automation_Bazaar_2)  
[Cloud 3](http://www.wordle.net/show/wrdl/4708002/Test_Automation_Bazaar_2012_%233)  


### Contributing to word_cloud

* Fork the project
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2012 Alan Baird. See LICENSE.txt for
further details.
