class @MarkdownEditor extends Plugin
  load: ->
    @$preview = $("<div/>").addClass('markdown-editor').insertAfter(@$dom)
    @loadEditor()
    @updateTextarea()
    @prettifyFullscreen()
    @inlineAttach()
    @updateHeight()

  loadEditor: ->
    @editor = new EpicEditor
      container: @$preview.get(0)
      basePath: '/assets'
      clientSideStorage: false
      theme:
        base: '/markdown_base.css'
        preview: '/markdown_preview.css',
        editor: '/markdown_editor.css'
    @editor.load()

    @$markdownEditor = $(@editor.getElement('editor')).find("body")
    @$markdownPreview = $(@editor.getElement('previewer')).find("body")

  updateTextarea: ->
    @$dom.hide()
    @editor.importFile('textarea', @$dom.val())

    @editor.on 'update', (file) =>
      @$dom.val @editor.exportFile('textarea', 'text')
      @updateHeight()

  prettifyFullscreen: ->
    @editor.on 'fullscreenenter', =>
      @fullscreen = true
      @$markdownEditor.addClass('fullscreen')
      @$markdownPreview.addClass('fullscreen')

    @editor.on 'fullscreenexit', =>
      @fullscreen = false
      @$markdownEditor.removeClass('fullscreen')
      @$markdownPreview.removeClass('fullscreen')
      @updateHeight()

  inlineAttach: ->
    EpicEditorAdapter = (editor) ->
      getValue: -> editor.exportFile('textarea', 'text')
      setValue: (val) -> editor.importFile('textarea', val)
    EpicEditorAdapter:: = new inlineAttach.Editor()

    editor = new EpicEditorAdapter(@editor)
    opts = { uploadUrl: '/en/image-assets/upload' }
    inlineattach = new inlineAttach(opts, editor)

    @$markdownEditor.bind
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

  updateHeight: ->
    unless @fullscreen
      editorHeight = @$markdownEditor.parent().outerHeight()
      editorHeight = 170 if editorHeight < 170
      @$preview.height(editorHeight)
      @editor.reflow()

