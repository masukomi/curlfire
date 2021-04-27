# curlfire ( firefox 💖 curl )

Run curl with the current [Firefox](https://www.mozilla.org/en-US/firefox/)
cookies. This is useful for interacting with logged in websites from the shell,
without having to manually deal with the login process.

> This is achieved by reading the **cookies.sqlite** file in Firefox profiles.

# Executable included in this package :

- `cookiefire` : used to extract cookies from Firefox.
- `curlfire` : used as `curl` wrapper that use cookies from Firefox.
- `curlfire-install` : perform _self update_ for `cookiefire`, `curlfire`,
  `curlfire-install`.

# Caveats

- **Does not work with session cookies**
  [(1)](https://support.mozilla.org/en-US/questions/899388) (you may be able to
  work around this by setting "Remember me" for the website with which you are
  using your tool)
- Only tested on linux machines
- Unlikely to work with windows
- Will probably work on macs since
  [a7a7bc7](https://github.com/ccdd13/curlfire/commit/a7a7bc72b5673369f55396e7db12bff4b8675f36)
  but untested (feedback welcome)

# Usages

```bash

# Fetch google with the cookies from the default profile
curlfire https://www.google.com

# Fetch google with the cookies from the default profile using curl arg -L : follow redirect
curlfire -L https://www.google.com

# Fetch google with the cookies from a specific profile
curlfire -P blah            https://www.google.com
curlfire -P guest           https://www.google.com
curlfire -P default         https://www.google.com
curlfire -P default-release https://www.google.com

# Getting cookies
cookiefire > ~/.cache/ff-cookies.txt
curl -b ~/.cache/ff-cookies.txt https://www.google.com

```

# Installation

```bash

curl -sLO 'https://raw.githubusercontent.com/ccdd13/curlfire/main/curlfire-install' | bash -x

# # same as Below
# mkdir       -p        "${HOME}/.local/bin" "${HOME}/.cache"
# git   clone --depth 1 https://github.com/ccdd13/curlfire          "${HOME}/.cache/curlfire"
# mv          -fv       "${HOME}/.cache/curlfire/cookiefire"        "${HOME}/.local/bin/cookiefire"
# mv          -fv       "${HOME}/.cache/curlfire/curlfire"          "${HOME}/.local/bin/curlfire"
# mv          -fv       "${HOME}/.cache/curlfire/curlfire-install"  "${HOME}/.local/bin/curlfire-install"
# chmod u+x             "${HOME}/.local/bin/*"
# rm          -rf       "${HOME}/.cache/curlfire"
# echo "${PATH}" | grep -Eq "(^|:)${HOME}/.local/bin(:|)" || echo "PATH=${HOME}/.local/bin:\${PATH}" >> "${HOME}/.bashrc"

```

**to update run `${HOME}/.local/curlfire/curlfire-install`**

# Complementary projects (and shameless advertising)

Users of this project might also be interested in:

- [clixpath](https://github.com/talwrii/clixpath) (by author) - an open-source
  tool for extracting information out of HTML documents in machine-readable JSON
  using [Xpath](https://www.w3.org/TR/1999/REC-xpath-19991116/).
- [PhantomJs](http://phantomjs.org/) - a scriptable command-line only browser
  than can be used to
  [render the document object model in Javascript based-websites](https://stackoverflow.com/a/9978162)
  and output more easily processed HTML.

# Alternatives and prior work

- Adapted from
  [this Stack Exchange answer](https://superuser.com/questions/666167/how-do-i-use-firefox-cookies-with-wget)
- Firebug and friends allow one to copy requests as curl commands. This can be
  suitable for debugging.
- Cookies can be exported manually from within Firefox

All of these approaches can be time consuming when automating tasks.

[Prior to Firefox 57](https://support.mozilla.org/en-US/kb/frequently-asked-questions-firefox-addon),
the
[remote control extension (archived)](https://web.archive.org/web/20181017212317/https://addons.mozilla.org/en-US/firefox/addon/remote-control/)
[(github)](https://github.com/FF-Remote-Control/FF-Remote-Control) could be used
to interact with the page currently viewed in Firefox from the shell (including
outputting the current
[document object model](https://en.wikipedia.org/wiki/Document_Object_Model) as
HTML).

# Attribution

This code is adapted from
[this Stack Exchange answer](https://superuser.com/a/1239036/653515) by
[hackerb9](https://superuser.com/users/400780/hackerb9).

# Copyright

This code is distributed under [an MIT license](LICENSE.txt).<br/> It contains
code adapted from a code snippet in the aforementioned Stack Exchange<br/>
answer which is also distributed under [an MIT license](SNIPPET-LICENSE.txt) as
[stipulated by the Stack Exchange terms and conditions](https://meta.stackexchange.com/questions/272956/a-new-code-license-the-mit-this-time-with-attribution-required).
