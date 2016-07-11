---
layout: default
title: About
permalink: /blog/
---

{% for post in site.posts %}

<div class="post">
  <div class="post-header">
    <h1><a href="{{ post.url }}">{{ post.title }}</a></h1>
  </div>

  <div class="post-content">
    {{ post.content }}
  </div>

  <div class='post-footer'>
    <a href="{{ post.url }}"><p>
      By Alex Gaudio at {{ post.date }}
    </p></a>
  </div>

{% endfor %}
