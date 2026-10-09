% cv.cls -- a minimalistic CV class
% https://github.com/HuberNicolas/minimalistic-cv-template
%
% Compiles with pdfLaTeX, XeLaTeX and LuaLaTeX (TeX Live 2022 or newer).
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{cv}[2026/10/09 v2.0 Minimalistic CV class]

% Pass all class options (e.g. 11pt, letterpaper) on to article
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% packages
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage[T1]{fontenc} % T1 Computer Modern (cm-super) has bold small capitals
\else
  \RequirePackage{fontspec}    % XeLaTeX/LuaLaTeX: Latin Modern, Unicode input
\fi
\RequirePackage{microtype}
\RequirePackage[a4paper, margin=0.75cm]{geometry} % page margins
\RequirePackage{titlesec}
\RequirePackage{enumitem} % list spacing
\RequirePackage{float}    % [H] placement for the section tables
\RequirePackage{etoolbox} % \ifblank
\RequirePackage[hidelinks]{hyperref} % load last

\pagestyle{empty}

% PDF metadata from \author and \title in the document preamble
\AtBeginDocument{\hypersetup{pdfauthor={\@author}, pdftitle={\@title}}}

% section headings
\titleformat{\section}         % Customise the \section command
  {\Large\scshape\raggedright} % large, small capitals, left aligned
  {}{0em}                      % no prefix like 'Section ...'
  {}                           % no code before the heading
  [\titlerule\vspace{-0.7\baselineskip}] % rule below the heading, reduced spacing

\titlespacing{\section}
  {0pt}               % left spacing
  {0.5\baselineskip}  % vertical spacing before section
  {0.5\baselineskip}  % vertical spacing after section

% list of entries below an entry title
\newcommand{\cv@items}[1]{%
  \begin{itemize}[itemsep=0pt, parsep=0pt, topsep=0pt, leftmargin=*]
    #1
  \end{itemize}%
}

% date column: "start --" over "end"; no dash if the end is empty
\newcommand{\cv@dates}[2]{%
  \begin{tabular}[t]{@{}l@{}}
    #1\ifblank{#2}{}{ --} \\ #2
  \end{tabular}%
}

% \centeredheader{name}{subtitle}{phone}{email}{website}
\newcommand{\centeredheader}[5]{%
  \begin{center}
    {\huge\scshape\bfseries #1} \\
    {\large\scshape #2} \\
    #3 \textbar{} \href{mailto:#4}{\texttt{#4}} \\
    {\small \href{#5}{#5}}
  \end{center}
}

% double title list: \dtList{start}{end}{bold title}{text}{\item ... \item ...}
% Leave the last argument empty for an entry without items.
\newcommand{\dtList}[5]{%
  \cv@dates{#1}{#2} &
  \begin{tabular}[t]{@{}p{0.9\linewidth}@{}}
    \textbf{#3} #4 \\
    \ifblank{#5}{}{\vspace{-\topsep}\cv@items{#5}}
  \end{tabular}%
}

% title list: \tList{start}{end}{bold title}{\item ... \item ...}
\newcommand{\tList}[4]{%
  \cv@dates{#1}{#2} &
  \begin{tabular}[t]{@{}p{0.9\linewidth}@{}}
    \textbf{#3} \\
    \ifblank{#4}{}{\vspace{-\topsep}\cv@items{#4}}
  \end{tabular}%
}

% skill entry: \skillEntry{skill}{level}
\newcommand{\skillEntry}[2]{%
  #1 & #2 \\
}

% License
% Template created by Nicolas Huber, nicolas.huber.dev@gmail.com
% Released under the MIT License, see the LICENSE file.
