---
title       : Two tools for reproducible data work
subtitle    : 
author      : Prabhas Pokharel, Modi Research Group
job         : 
framework   : io2012      # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
---

## What will you get out of this?

* **R users**: Get introduced to [R-Markdown](http://www.rstudio.com/ide/docs/authoring/using_markdown), a tool for doing data analysis and presentation work together.

* **Other data people**: Get introduced to [make](https://en.wikipedia.org/wiki/Make_software), which lets you write down steps to reproduce data pipelines.

* **Bonus, (most immediately applicable) for R folks**: `makemake` (or `pipelineR`), a tool to use make without most of the work.

---
## The theme

Data analysis, visualization, presentation, whatever, should be **reproducible**.

Our aim is to automate the "re-creation" / "reproduction".

What you get out of easy / automated reproduction:

 * work becomes easy to **share**
 * easy to **iterate on**
 * easy to **collaborate with others**
 * easier to **hand off**

---.segue .dark
## Tool #1 -- RMarkdown

---
## But first, an aside
<iframe src="http://www.darkcoding.net/software/markdown-quick-reference/" width="801" height="601"></iframe>

---

## Rmd has made two things easier, for me:
* `literate` / exploratory data analysis (ie, explain what you are doing)
* data-based presentations (explanations in pictures)

---
## 1.1 "Literate" data analysis -- explain what you are doing

* [How to make choropleths in R](http://bl.ocks.org/prabhasp/raw/5030005/)

* [Analyzing how the Times writes about men vs. women](http://nbviewer.ipython.org/5105037) -- Neal Caren

* [Bamboo benchmarks](http://bl.ocks.org/prabhasp/raw/5156070/)

* [Nigeria coverage gap analysis without facility lists](http://bl.ocks.org/prabhasp/raw/4529702/)

---
## A deeper dive -- "How to make Choropleths in R"

<iframe src="http://bl.ocks.org/prabhasp/raw/5030005/" width="801" height="601"></iframe>

---
## Directory structure

```r
list.files("~/Code/gists/NepalChoropleths/")
```

```
## [1] "index.html"                 "index.rmd"                 
## [3] "zfstat-062 reformatted.csv" "zfstat-063 reformatted.csv"
```


 * File organization: `index.Rmd` compiles to `index.md` and `index.html`
   * In this case, the data is in the same directory
 * If you host this work in github, there are automatic renders available. For `github`, if you create a `gh-pages` branch, `index.html` files are auto-rendered at `YOURUSERNAME.github.io/REPONAME/`. For github gists, use [http://bl.ocks.org/YOURGITHUBUSERNAME](http://bl.ocks.org/prabhasp).

---
## Rmd syntax

* The file itself
  * Code and markdown are interspersed together
  * "Compilation": "Knit HTML" button
  * Or directly: `setwd(appropriate directory)`; `knit2html('index.Rmd')`.
<iframe src="http://gist.github.com/prabhasp/5030005#file-index-rmd/" width="801" height="601"></iframe>

---
## 1.2 Hide the code

The code block can include many options (caching, showing warnings or not, heights and widths of figures). If we simply hide the code, we can get documents which aren't about explaining what you did, but your results!
<iframe src="http://bl.ocks.org/prabhasp/raw/5156070/" width="801" height="601"></iframe>

---
## 1.2 Hide the code -- Presentations!

Finally, if you employ the convention of using the line breaks `---` as slide breaks, this file can convert readily to a presentation!
* [Visualizing Health Access in Haiti](http://prabhasp.github.io/Haiti-Health-Access-Analysis/)
* [Visualizing Energy Access in Nigeria](http://prabhasp.github.io/Presentations/prabhas/energy-summaries/)
* [Mopup, a summary](http://prabhasp.github.io/Presentations/prabhas/kigali-mopup-presentation)

For instructions, see [slidify](http://slidify.org/)

---

## Presentations deep dive

<iframe src="http://prabhasp.github.io/Presentations/prabhas/kigali-mopup-presentation/" width="801" height="601"></iframe> 
 
---
## Some Rmd words of wisdom:

* Learn `ggplot2`. Its an amazing graphics library that lets you make graphics as you make the data for the graphics. javascript has got nothing (besides interactivity) on `ggplot`.

* The "slides" version of this I've found most useful in my work. A great way of leading people through analysis.

* You can "print" the slides to pdf, and even convert them to ppt if you have Adobe Acrobat Pro.

---.segue .dark
So that was **cool**, how about something useful?

---
[http://bost.ocks.org/mike/make/](http://bost.ocks.org/mike/make/)

---
## How make has made **our** lives easier: The Nigeria Project

![NMIS-Pipeline-1](NMIS_Indicator_Pipeline-1.png)

---
## How make has made **our** lives easier: The Nigeria Project

![NMIS-Pipeline-2](NMIS_Indicator_Pipeline-2.png)

---
## A makefile can help us with that!
![NMIS-Pipeline-2](NMIS_Indicator_Pipeline-2.png)
```
merged.csv: raw_data_1.csv raw_data_2.csv raw_data_1.csv Merge.R
    Rscript Merge.R
dropped.csv: merged.csv DropOutliers.R
    Rscript DropOutliers.R
facility.csv: dropped.csv FacilityIndicators.R
    Rscript FacilityIndicators.R
lga.csv: faclity.csv LGAIndicators.R
    Rscript LGAIndicators.R
```

---
## Cool!
 * make helped us basically "write down" our pipeline
 * reproduction is as simple as typing "make" on the command line
 * document the process

---
## But there is more.
What I showed you before was a very simplistic picture, the NMIS pipeline actually looks like this:

![Dependency Graph](dependency_graph.png)

How big is this Makefile?
---
## MakeMake

 * analyses a folder worth of R scripts, and writes your makefile for you.
 * looks at function calls like "read.csv", "write.csv" and other things like that
   to figure out what your scripts read and write, and auto-write a makefile.
 * also can run a dependency analyzer for you.

---
## How to use
 * Once a name decision is made, look for it on github.com/modilabs
 * (makemake, makemakeR, pipelineR) 

---
## Lessons

 * make is super useful. I even use it for smaller projects (Haiti demo?).
 * for Rmarkdown projects, I write a small makefile that links index.html and index.Rmd together. Then, as I'm modifying the project, I run `while TRUE; do make; sleep 10; done` on the command line; every ten minutes, my presentation is re-compiled if I have modified it recently.
 * if you don't have the rights to re-distribute data, great way to tell people what data they need.

--- .centered
## Thank You

Prabhas Pokharel

[Sustainable Engineering Group](http://modi.mech.columbia.edu)

Earth Institute

Columbia University
