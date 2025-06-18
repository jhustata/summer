# 🎓 Preface

Welcome to the [340.600](https://publichealth.jhu.edu/course/41687) Summer Institute Course in Stata Programming!

This class will be offered in a hybrid-format to cater to both those who will be in-person at the Bloomberg School (Wolfe **W3031**) and those who will be joining us virtually (Zoom [link](https://us06web.zoom.us/j/86492592698)). In-person attendees are encouraged to also log into zoom, which allows students to share code and to collectively `debug`. Students in previous summers described this as one of the best aspects of their learning experience. 

By contrast, exclusively in-person class formats without the zoom option make it difficult for students to articulate the issues they might be confronting. This makes collective troubleshooting a nightmare. 

Our class will be structured as follows:
   
   + 8:30-10:15 lecture
   + 10:15-10:45 lab
   + 10:45-11:00 break
   + 11:00-11:50 lecture
   + 11:50-12:20 lab     
     
Evaluation of your progress will be done on a daily basis:

   + One graded lab per day (in-class)
   + An optional assignment given at the end of the class
   + We encourage you to do the in-class labs even if you're not taking the class for credit
   + Everyone who turns in every lab + the final assignment (on time) will get an A or a B

For **general** inquiries about Course logistics, Homework submission, etc., please use the [CoursePlus Discussion Forum](https://courseplus.jhu.edu/core/index.cfm/go/home/). For confidential matters (e.g., grades), [email your course team](https://jhustata.github.io/summer/quickrefs#your-instructor) directly.

Join our [Stata-focused discussion community on GitHub](https://github.com/jhustata/summer/discussions) for all your code-related queries! Whether you're looking to share snippets, troubleshoot issues with your peers, or dive into broader discussions within the Hopkins Stata community, GitHub is your go-to platform. Don't have a GitHub account yet? No worries—it's quick and easy to [sign up](https://github.com/join). This platform not only facilitates collaboration with your classmates and instructors but also connects you to the wider Stata-using community at Hopkins even after completion of this course. Get ready to enhance your coding journey by tapping into the collective wisdom and insights available right at your fingertips.


Sharing code on the GitHub discussion forum is straightforward. Simply enclose your code snippet or an entire `.do` file's contents within triple backquotes for syntax highlighting, like this:

\```stata      
copy & paste your code snippet here     
\```   

If you are not sure where the `backquote` is, its to the left of "1" on most keyboards. The forwardquote is to the left of "return" on a Mac. You need to get familiar with these quotes, since they'll be used to specify "macros" throughout this class and your programming life. While using a .do file, the use of a back quote will automatically generate a forward quote to enclose the specified macro as seen below.

```stata
di `c(N)'
```

![](https://media.istockphoto.com/id/168823323/photo/modern-laptop-computer-keyboard.jpg?s=2048x2048&w=is&k=20&c=1EUUYqgTO1bRR5wqebm56g5xV4R69LKcK5LQtSwbnd8=)

You don't need to upload `.do` files. For Python or R code, just replace "stata" with "python" or "r" respectively. This syntax highlighting enhances readability, making it easier for peers to understand your code. This is why we prefer GitHub for discussing code-related queries over CoursePlus. Feel free to mix your explanations with code snippets to better illustrate your points.

Zoom etiquette is straightforward: all participants will be muted except the lecturer. Feel free to ask questions via chat, which we’ll monitor regularly. **During class, labs, and homework attempts**, post questions and comments the [Stata-focused discussion community on GitHub](https://github.com/jhustata/summer/discussions) for peer reference. While we aim to record lectures, live attendance is recommended when possible.

Regarding academic integrity, we encourage the use of small code snippets from books, the internet, or peers, provided they're cited, as shown below:

```stata
tokenize `c(ALPHA)'  // Adapted from https://www.statalist.org/forums/forum/general-stata-discussion/general/1380433-creating-a-counter-with-alphabets
```

Leveraging AI, including ChatGPT, as a co-pilot, guide, or assistant, is <u>strongly encouraged</u> both during and after this course.

## Table of contents

```{tableofcontents}
```
