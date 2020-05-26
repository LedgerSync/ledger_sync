/**
 * Main JS file for theme behaviours
 */
// Responsive video embeds
let videoEmbeds = [
  'iframe[src*="youtube.com"]',
  'iframe[src*="vimeo.com"]'
];
reframe(videoEmbeds.join(','));

// Remove nav related classes on page load
document.body.classList.remove('menu--opened', 'toc--opened');

// Menu on small screens
let menuToggle = document.querySelectorAll('.menu-toggle');
if (menuToggle) {
  for (let i = 0; i < menuToggle.length; i++) {
    menuToggle[i].addEventListener('click', function (e) {
      document.body.classList.toggle('menu--opened');
      e.preventDefault();
    }, false);
  }
}

// Dropdown arrow
let mainMenu = document.getElementById('main-navigation');
let submenu = mainMenu.querySelectorAll('.submenu');
if (submenu) {
  for (let i = 0; i < submenu.length; i++) {
    let submenuBtn = document.createElement('button');
    submenuBtn.setAttribute('class','submenu-toggle');
    submenuBtn.innerHTML = '<span class="icon-angle-right" aria-hidden="true"></span><span class="screen-reader-text">Sub-menu</span>';
    submenu[i].parentNode.insertBefore(submenuBtn, submenu[i]);
    submenuBtn.addEventListener ('click', function() {
      this.classList.toggle('active');
      this.nextSibling.classList.toggle('active');
    });
  }

}


let guidesNav = document.getElementById('guides-nav');
if (guidesNav) {
  // Docs nav on small screens
  let guidesNavToggle = document.getElementById('guides-nav-toggle');
  guidesNavToggle.addEventListener('click', function (e) {
    document.body.classList.toggle('toc--opened');
    e.preventDefault();
  }, false);

  // Submenu toggle
  let submenuToggle = guidesNav.querySelectorAll('.submenu-toggle');
  for (let i = 0; i < submenuToggle.length; i++) {
    submenuToggle[i].addEventListener('click', function (e) {
      submenuToggle[i].parentNode.classList.toggle('active');
    }, false);
  }
}

let pageNav = document.getElementById('page-nav');
if (pageNav) {

  let pageToc = document.getElementById('page-nav-inside');
  let pageContent = document.querySelector('.type-guides .post-content');

  // Create in-page navigation
  let headerLinks = getHeaderLinks({
    root: pageContent
  });
  renderHeaderLinks(pageToc, headerLinks);

  // Scroll to anchors
  let scroll = new SmoothScroll('[data-scroll]');
  let hash = window.decodeURI(location.hash.replace('#', ''));
  if (hash !== '') {
    window.setTimeout( function(){
      let anchor = document.getElementById(hash);
      if (anchor) {
        scroll.animateScroll(anchor);
      }
    }, 0);
  }

  // Highlight current anchor
  let pageTocLinks = pageToc.getElementsByTagName('a');
  if (pageTocLinks.length > 0) {
    let spy = new Gumshoe('#page-nav-inside a', {
      nested: true,
      nestedClass: 'active-parent'
    });
  }

  // Add link to page content headings
  let pageHeadings = getElementsByTagNames(pageContent, ["h2", "h3"]);
  for (let i = 0; i < pageHeadings.length; i++) {
    let heading = pageHeadings[i];
    if (typeof heading.id !== "undefined" && heading.id !== "") {
      heading.insertBefore(anchorForId(heading.id), heading.firstChild);
    }
  }

  // Copy link url
  let clipboard = new ClipboardJS('.hash-link', {
    text: function(trigger) {
      return window.location.href.replace(window.location.hash,"") + trigger.getAttribute('href');
    }
  });
}

function getElementsByTagNames(root, tagNames) {
  let elements = [];
  for (let i = 0; i < root.children.length; i++) {
    let element = root.children[i];
    let tagName = element.nodeName.toLowerCase();
    if (tagNames.includes(tagName)) {
      elements.push(element);
    }
    elements = elements.concat(getElementsByTagNames(element, tagNames));
  }
  return elements;
}

function createLinksForHeaderElements(elements) {
  let result = [];
  let stack = [
    {
      level: 0,
      children: result
    }
  ];
  let re = /^h(\d)$/;
  for (let i = 0; i < elements.length; i++) {
    let element = elements[i];
    let tagName = element.nodeName.toLowerCase();
    let match = re.exec(tagName);
    if (!match) {
      console.warn("can not create links to non header element");
      continue;
    }
    let headerLevel = parseInt(match[1], 10);
    if (!element.id) {
      if (!element.textContent) {
        console.warn(
          "can not create link to element without id and without text content"
        );
        continue;
      }
      element.id = element.textContent
        .toLowerCase()
        .replace(/[^\w]+/g, "_")
        .replace(/^_/, "")
        .replace(/_$/, "");
    }
    let link = document.createElement("a");
    link.href = "#" + element.id;
    link.setAttribute('data-scroll', '');
    link.appendChild(document.createTextNode(element.textContent));
    let obj = {
      id: element.id,
      level: headerLevel,
      textContent: element.textContent,
      element: element,
      link: link,
      children: []
    };
    if (headerLevel > stack[stack.length - 1].level) {
      stack[stack.length - 1].children.push(obj);
      stack.push(obj);
    } else {
      while (headerLevel <= stack[stack.length - 1].level && stack.length > 1) {
        stack.pop();
      }
      stack[stack.length - 1].children.push(obj);
      stack.push(obj);
    }
  }
  return result;
}

function getHeaderLinks(options = {}) {
  let tagNames = options.tagNames || ["h2", "h3"];
  let root = options.root || document.body;
  let headerElements = getElementsByTagNames(root, tagNames);
  return createLinksForHeaderElements(headerElements);
}

function renderHeaderLinks(element, links) {
  if (links.length === 0) {
    return;
  }
  let ulElm = document.createElement("ul");
  for (let i = 0; i < links.length; i++) {
    let liElm = document.createElement("li");
    liElm.append(links[i].link);
    if (links[i].children.length > 0) {
      renderHeaderLinks(liElm, links[i].children);
    }
    ulElm.appendChild(liElm);
  }
  element.appendChild(ulElm);
}

function anchorForId(id) {
  let anchor = document.createElement("a");
  anchor.setAttribute("class", "hash-link");
  anchor.setAttribute("data-scroll", "");
  anchor.href = "#" + id;
  anchor.innerHTML = '<span class="icon-copy" aria-hidden="true"></span><span class="screen-reader-text">Copy</span>';
  return anchor;
}

// Syntax Highlighter
Prism.highlightAll();