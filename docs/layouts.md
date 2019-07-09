---
id: layouts
title: Layouts
sidebar_label: Layouts
---

---

## Overview
> In all versions of Amphora before v7.x layouts are managed in the /components directory inside of your Clay instance. In v7.x and above the layouts are managed in their own directory, /layouts.
A layout is shared between multiple pages. Whenever the structure of a page needs to be different, then you should create a new layout.

Layouts have all the same affordances as components, but there are a few important characteristics of layouts:
* Each page must have a reference to exactly one layout instance
* Layouts have Page Areas
* Layouts have their own metadata

## Page Areas
Layouts are unique because they can contain placeholders for properties on a page that are filled during composition. The areas where a page's data can be merged into the layout's data are called **page areas**. The reference to a page area is simply a string that references a [component-list on a page](pages#page-specific-data).

For example:

```js
// Page data
{
    layout: "domain.com/_layouts/layout/instances/default",
    main: [
        "domain.com/_components/post/instances/good-post"
    ]
}
```
```js
// Layout data
{
    head: [{
        _ref: "domain.com/_components/meta-title/instances/default"
    }],
    main: "main",
    foot: [{
        _ref: "domain.com/_components/footer/instances/default"
    }]
}
```

During composition of the page for rendering the data from the page will be merged into the layout:
```js
// Composed page data
{
    head: [{
        _ref: "domain.com/_components/meta-title/instances/default"
    }],
    main: [{
        _ref: "domain.com/_components/post/instances/good-post"
    }]
    foot: [{
        _ref: "domain.com/_components/footer/instances/default"
    }]
}
```

> It should be noted that during composition all of the component data will also be included in the composed page, but for demonstration purposes we're only showing how references for the page are combined with the layout.

---

## Defining Page Areas For Editing
While referencing data from a page works by setting a property in the layout to the same value as a component-list in the page data, there's a little more that has to be done so that Kiln knows how to edit page areas properly. For more detailed information, [see the Kiln docs](https://docs.clayplatform.com/clay-kiln/docs/intro), but below is a brief excerpt from a Layout schema that is defining a Page Area called "main".
```js
main:
  _componentList:
    page: true
    include:
      - post
      - general-content
```
Setting `page: true` in the layout's schema for the component-list lets Kiln know that when a user is adding data to this component-list that the page instance should be updated and not the layout instance.
