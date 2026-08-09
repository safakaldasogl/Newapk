.class public Lcom/archi/app/ArchiChromeClient;
.super Landroid/webkit/WebChromeClient;

.field private activity:Lcom/archi/app/MainActivity;

.method public constructor <init>(Lcom/archi/app/MainActivity;)V
    .registers 2
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V
    iput-object p1, p0, Lcom/archi/app/ArchiChromeClient;->activity:Lcom/archi/app/MainActivity;
    return-void
.end method

# Dosya seçici - <input type="file"> için
.method public onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    .registers 8

    iget-object v0, p0, Lcom/archi/app/ArchiChromeClient;->activity:Lcom/archi/app/MainActivity;

    # Varsa mevcut callback'i iptal et
    iget-object v1, v0, Lcom/archi/app/MainActivity;->mFilePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v1, :no_existing
    const/4 v2, 0x0
    invoke-interface {v1, v2}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V

    :no_existing
    # Yeni callback'i kaydet
    iput-object p2, v0, Lcom/archi/app/MainActivity;->mFilePathCallback:Landroid/webkit/ValueCallback;

    # Dosya seçici Intent
    new-instance v1, Landroid/content/Intent;
    const-string v2, "android.intent.action.GET_CONTENT"
    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "*/*"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "android.intent.category.OPENABLE"
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const-string v2, "Dosya Seç"
    invoke-static {v1, v2}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;
    move-result-object v1

    const/16 v2, 0x64
    invoke-virtual {v0, v1, v2}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    const/4 v0, 0x1
    return v0
.end method

# Kamera/mikrofon izinlerini otomatik ver
.method public onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    .registers 2
    invoke-virtual {p1}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V
    return-void
.end method
