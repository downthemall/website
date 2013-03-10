EpicEditorAdapter = (editor) ->
  getValue: ->
    editor.exportFile('textarea', 'text')
  setValue: (val) ->
    editor.importFile('textarea', val)

EpicEditorAdapter:: = new inlineAttach.Editor()

class @MarkdownEditor extends Plugin
  load: ->
    @$preview = $("<div/>").addClass('markdown-editor').insertAfter(@$dom)

    @editor = new EpicEditor
      container: @$preview.get(0)
      basePath: '/assets'
      clientSideStorage: false
      theme:
        base: '/markdown_base.css'
        preview: '/markdown_preview.css',
        editor: '/markdown_editor.css'

    @editor.load()
    @$dom.hide()
    @editor.importFile('textarea', @$dom.val())

    @editor.on 'update', (file) =>
      @$dom.val @editor.exportFile('textarea', 'text')
      @updateHeight()

    @editor.on 'fullscreenenter', =>
      @fullscreen = true
      $(@editor.getElement('editor')).find("body").addClass('fullscreen')
      $(@editor.getElement('previewer')).find("body").addClass('fullscreen')

    @editor.on 'fullscreenexit', =>
      @fullscreen = false
      @updateHeight()
      $(@editor.getElement('editor')).find("body").removeClass('fullscreen')
      $(@editor.getElement('previewer')).find("body").removeClass('fullscreen')

    editor = new EpicEditorAdapter(@editor)
    opts =
      uploadUrl: '/en/image-assets/upload'

    inlineattach = new inlineAttach(opts, editor)

    $(@editor.getElement('editor')).find("body").bind

      drop: (e) =>
        e.stopPropagation()
        e.preventDefault()
        @$preview.removeClass('dragging')
        console.log e.originalEvent
        inlineattach.onDrop e.originalEvent

      dragenter: (e) =>
        e.stopPropagation()
        e.preventDefault()
        @$preview.addClass('dragging')

      dragleave: (e) =>
        e.stopPropagation()
        e.preventDefault()
        @$preview.removeClass('dragging')

    @updateHeight()

  updateHeight: ->
    unless @fullscreen
      editorHeight = $(@editor.getElement('editor')).height()
      @$preview.height(editorHeight)
      @editor.reflow()
