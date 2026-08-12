.class public Lcom/archii/app/MainActivity;
.super Landroid/app/Activity;

.field private webView:Landroid/webkit/WebView;
.field public mFilePathCallback:Landroid/webkit/ValueCallback;

.method public constructor <init>()V
    .registers 1
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 8

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const/4 v0, 0x1
    invoke-virtual {p0, v0}, Landroid/app/Activity;->requestWindowFeature(I)Z

    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;
    move-result-object v0
    const v1, 0x400
    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/archii/app/MainActivity;->webView:Landroid/webkit/WebView;

    const v1, -0xF3F1EC
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setBackgroundColor(I)V

    const/4 v1, 0x0
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setInitialScale(I)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccessFromFileURLs(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowUniversalAccessFromFileURLs(Z)V

    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V

    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    const/4 v2, 0x0
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V

    const/4 v2, -0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    const/16 v2, 0x64
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setTextZoom(I)V

    new-instance v3, Lcom/archii/app/ArchiiJSInterface;
    invoke-direct {v3, p0}, Lcom/archii/app/ArchiiJSInterface;-><init>(Landroid/content/Context;)V

    const-string v4, "ArchiApp"
    invoke-virtual {v0, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v4, Lcom/archii/app/ArchiiDownloadListener;
    invoke-direct {v4, v0, v3}, Lcom/archii/app/ArchiiDownloadListener;-><init>(Landroid/webkit/WebView;Lcom/archii/app/ArchiiJSInterface;)V
    invoke-virtual {v0, v4}, Landroid/webkit/WebView;->setDownloadListener(Landroid/webkit/DownloadListener;)V

    new-instance v4, Lcom/archii/app/ArchiiChromeClient;
    invoke-direct {v4, p0}, Lcom/archii/app/ArchiiChromeClient;-><init>(Lcom/archii/app/MainActivity;)V
    invoke-virtual {v0, v4}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    new-instance v4, Landroid/webkit/WebViewClient;
    invoke-direct {v4}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v4}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    const-string v4, "file:///android_asset/index.html"
    invoke-virtual {v0, v4}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .registers 10

    const/16 v0, 0x64
    if-ne p1, v0, :super_call

    iget-object v1, p0, Lcom/archii/app/MainActivity;->mFilePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v1, :done

    const/4 v2, -0x1
    if-ne p2, v2, :cancelled
    if-eqz p3, :cancelled

    invoke-virtual {p3}, Landroid/content/Intent;->getDataString()Ljava/lang/String;
    move-result-object v3
    if-eqz v3, :cancelled

    invoke-static {v3}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v3

    const/4 v4, 0x1
    new-array v4, v4, [Landroid/net/Uri;
    const/4 v5, 0x0
    aput-object v3, v4, v5

    invoke-interface {v1, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    goto :clear_callback

    :cancelled
    const/4 v3, 0x0
    invoke-interface {v1, v3}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    :clear_callback
    const/4 v2, 0x0
    iput-object v2, p0, Lcom/archii/app/MainActivity;->mFilePathCallback:Landroid/webkit/ValueCallback;
    return-void

    :super_call
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    :done
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .registers 5

    const/4 v0, 0x4
    if-ne p1, v0, :not_back

    iget-object v0, p0, Lcom/archii/app/MainActivity;->webView:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->canGoBack()Z
    move-result v1
    if-eqz v1, :not_back

    invoke-virtual {v0}, Landroid/webkit/WebView;->goBack()V
    const/4 v0, 0x1
    return v0

    :not_back
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z
    move-result v0
    return v0
.end method
