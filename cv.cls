% cv.cls -- a minimalistic CV class
% https://github.com/HuberNicolas/minimalistic-cv-template
%
% Styles (class option):
%   academic   (default) Computer Modern, small capitals, dates in a left column
%   corporate  Source Sans, accent color, dates right-aligned on the title line
%
% Compiles with pdfLaTeX, XeLaTeX and LuaLaTeX (TeX Live 2022 or newer).
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{cv}[2026/10/09 v2.1 Minimalistic CV class]

\newif\ifcv@corporate
\DeclareOption{academic}{\cv@corporatefalse}
\DeclareOption{corporate}{\cv@corporatetrue}
% Pass all other class options (e.g. 11pt) on to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% packages
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[T1]{fontenc} % T1 Computer Modern (cm-super) has bold small capitals
  % Machine-readable text for applicant tracking systems:
  % real space characters and Unicode mappings for ligatures
  \input{glyphtounicode}
  \pdfgentounicode=1
  \pdfinterwordspaceon
\else
  \RequirePackage{fontspec}    % XeLaTeX/LuaLaTeX: Unicode input
\fi
\ifcv@corporate
  \RequirePackage[default]{sourcesans} % Source Sans as the main font
\fi
\RequirePackage{microtype}
\RequirePackage[a4paper, margin=1.5cm]{geometry} % change with \geometry{margin=...}
\RequirePackage{xcolor}
\RequirePackage{titlesec}
\RequirePackage{enumitem} % list spacing
\RequirePackage{float}    % [H] placement for the section tables
\RequirePackage{etoolbox} % \ifblank
\RequirePackage[hidelinks]{hyperref} % load last

\pagestyle{empty}
\setlength{\parindent}{0pt}

% PDF metadata from \author and \title in the document preamble
\AtBeginDocument{\hypersetup{pdfauthor={\@author}, pdftitle={\@title}}}

% accent color for name, headings and rules; redefine with \definecolor{cvaccent}{...}
\ifcv@corporate
  \definecolor{cvaccent}{RGB}{31, 78, 121}
\else
  \definecolor{cvaccent}{RGB}{0, 0, 0}
\fi

% section headings
\ifcv@corporate
  \titleformat{\section}
    {\large\bfseries\color{cvaccent}\raggedright}
    {}{0em}{}
    [{\color{cvaccent}\titlerule}]
\else
  \titleformat{\section}         % Customise the \section command
    {\Large\scshape\raggedright} % large, small capitals, left aligned
    {}{0em}                      % no prefix like 'Section ...'
    {}                           % no code before the heading
    [\titlerule]                 % rule below the heading
\fi
\titlespacing{\section}
  {0pt}               % left spacing
  {0.6\baselineskip}  % vertical spacing before section
  {0.4\baselineskip}  % vertical spacing after section

% little space around the [H] tables that hold the entries
\setlength{\intextsep}{0pt plus 2pt}

% header: \cvheader{name}{subtitle}{contact line}{links line}
% Separate items with \cvsep; leave a line empty to drop it.
\newcommand{\cvsep}{\enspace\textbar\enspace}
\newcommand{\email}[1]{\href{mailto:#1}{#1}}
\newcommand{\weblink}[1]{\href{https://#1}{#1}} % \weblink{github.com/user}
\newcommand{\cvheader}[4]{%
  \begin{center}
    \ifcv@corporate
      {\Huge\bfseries\color{cvaccent}#1}\par\smallskip
      \ifblank{#2}{}{{\large #2}\par\smallskip}
    \else
      {\huge\scshape\bfseries #1}\par
      \ifblank{#2}{}{{\large\scshape #2}\par}
    \fi
    \ifblank{#3}{}{#3\par}
    \ifblank{#4}{}{{\small #4}\par}
  \end{center}
}

% v1 header, kept for existing CVs: \centeredheader{name}{subtitle}{phone}{email}{website}
\newcommand{\centeredheader}[5]{%
  \cvheader{#1}{#2}{#3\cvsep\href{mailto:#4}{\texttt{#4}}}{\href{#5}{#5}}%
}

% list of entries below an entry title
\newcommand{\cv@items}[1]{%
  \begin{itemize}[itemsep=0pt, parsep=0pt, topsep=0pt, leftmargin=*]
    #1
  \end{itemize}%
}

% Entries are rows of a two-column tabular ({ll}), see the templates.
% \dtList{start}{end}{bold title}{text}{\item ... \item ...}
% \tList{start}{end}{bold title}{\item ... \item ...}
% Leave the items empty for an entry without bullets, and end empty for a single date.
\newlength{\cvdatewidth}
\setlength{\cvdatewidth}{1.8cm} % academic: width of the date column
\newlength{\cv@textwidth}
\AtBeginDocument{\setlength{\cv@textwidth}{\dimexpr\textwidth-\cvdatewidth-4\tabcolsep\relax}}

\ifcv@corporate
  % one cell across both columns; dates right-aligned on the title line
  \newcommand{\cv@entry}[4]{% start, end, title line, items
    \multicolumn{2}{@{}p{\textwidth}@{}}{%
      #3\hfill{\small #1\ifblank{#2}{}{ -- #2}}%
      \ifblank{#4}{}{\cv@items{#4}}\vspace{3pt}}%
  }
\else
  % date column "start --" over "end", text column to its right
  \newcommand{\cv@entry}[4]{%
    \begin{tabular}[t]{@{}p{\cvdatewidth}@{}}
      #1\ifblank{#2}{}{ --} \\ #2
    \end{tabular} &
    \begin{tabular}[t]{@{}p{\cv@textwidth}@{}}
      #3 \\
      \ifblank{#4}{}{\vspace{-\topsep}\cv@items{#4}}
    \end{tabular}%
  }
\fi
\newcommand{\dtList}[5]{\cv@entry{#1}{#2}{\textbf{#3} #4}{#5}}
\newcommand{\tList}[4]{\cv@entry{#1}{#2}{\textbf{#3}}{#4}}

% skill entry: \skillEntry{skill}{level}
\newlength{\cvlabelwidth}
\setlength{\cvlabelwidth}{2.4cm} % corporate: width of the skill label column
\ifcv@corporate
  \newcommand{\skillEntry}[2]{\multicolumn{1}{@{}p{\cvlabelwidth}}{\textbf{#1}} & #2 \\}
\else
  \newcommand{\skillEntry}[2]{#1 & #2 \\}
\fi

% License
% Template created by Nicolas Huber, nicolas.huber.dev@gmail.com
% Released under the MIT License, see the LICENSE file.
