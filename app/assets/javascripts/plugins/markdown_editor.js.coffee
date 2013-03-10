class @MarkdownEditor extends Plugin
  load: ->
    @$preview = $("<div/>").addClass('markdown-editor').insertAfter(@$dom)
    @editor = new EpicEditor
      container: @$preview.get(0)
      basePath: '/assets'
      theme:
        base: '/markdown_base.css'
        preview: '/markdown_preview.css',
        editor: '/markdown_editor.css'

    @editor.load()
    @$dom.hide()
    @editor.importFile(null, @$dom.val())
    @editor.on 'update', (file) => @$dom.val(file.content)

    @editor.on 'fullscreenenter', =>
      $(@editor.getElement('editor')).find("body").addClass('fullscreen')
      $(@editor.getElement('previewer')).find("body").addClass('fullscreen')

    @editor.on 'fullscreenexit', =>
      $(@editor.getElement('editor')).find("body").removeClass('fullscreen')
      $(@editor.getElement('previewer')).find("body").removeClass('fullscreen')


