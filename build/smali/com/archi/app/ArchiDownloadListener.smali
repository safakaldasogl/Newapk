.class public Lcom/archi/app/ArchiDownloadListener;
.super Ljava/lang/Object;
.implements Landroid/webkit/DownloadListener;

.field private webView:Landroid/webkit/WebView;
.field private jsInterface:Lcom/archi/app/ArchiJSInterface;

.method public constructor <init>(Landroid/webkit/WebView;Lcom/archi/app/ArchiJSInterface;)V
    .registers 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/archi/app/ArchiDownloadListener;->webView:Landroid/webkit/WebView;
    iput-object p2, p0, Lcom/archi/app/ArchiDownloadListener;->jsInterface:Lcom/archi/app/ArchiJSInterface;
    return-void
.end method

# url, userAgent, contentDisposition, mimetype, contentLength
.method public onDownloadStart(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .registers 12

    # --- blob: URL mi? JS ile yakala ---
    const-string v0, "blob:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :check_data

    iget-object v1, p0, Lcom/archi/app/ArchiDownloadListener;->webView:Landroid/webkit/WebView;

    # JS: fetch(blobUrl) → FileReader → ArchiApp.saveFile(dataUrl, filename)
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "javascript:(function(){fetch('"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v3, "').then(function(r){return r.blob();}).then(function(b){var rd=new FileReader();rd.onloadend=function(){ArchiApp.saveFile(rd.result,'archi-yedek.json');};rd.readAsDataURL(b);});})();"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void

    # --- data: URL mi? Doğrudan kaydet ---
    :check_data
    const-string v0, "data:"
    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :done

    iget-object v1, p0, Lcom/archi/app/ArchiDownloadListener;->jsInterface:Lcom/archi/app/ArchiJSInterface;
    const-string v2, "archi-yedek.json"
    invoke-virtual {v1, p1, v2}, Lcom/archi/app/ArchiJSInterface;->saveFile(Ljava/lang/String;Ljava/lang/String;)V

    :done
    return-void
.end method
