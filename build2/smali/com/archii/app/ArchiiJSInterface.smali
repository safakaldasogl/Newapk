.class public Lcom/archii/app/ArchiiJSInterface;
.super Ljava/lang/Object;

.field private context:Landroid/content/Context;

.method public constructor <init>(Landroid/content/Context;)V
    .registers 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/archii/app/ArchiiJSInterface;->context:Landroid/content/Context;
    return-void
.end method

.method public saveFile(Ljava/lang/String;Ljava/lang/String;)V
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    .registers 11

    iget-object v0, p0, Lcom/archii/app/ArchiiJSInterface;->context:Landroid/content/Context;

    const-string v1, "base64,"
    invoke-virtual {p1, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I
    move-result v2

    if-ltz v2, :done

    add-int/lit8 v2, v2, 0x7
    invoke-virtual {p1, v2}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v3

    const/4 v4, 0x0
    invoke-static {v3, v4}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B
    move-result-object v5

    const/4 v6, 0x0
    invoke-virtual {v0, v6}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;
    move-result-object v6

    new-instance v7, Ljava/io/File;
    invoke-direct {v7, v6, p2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    :try_start
    new-instance v8, Ljava/io/FileOutputStream;
    invoke-direct {v8, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    invoke-virtual {v8, v5}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v8}, Ljava/io/FileOutputStream;->close()V
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch_all

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;
    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V
    const-string v10, "Kaydedildi: "
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8

    const/4 v9, 0x0
    invoke-static {v0, v8, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;
    move-result-object v9
    invoke-virtual {v9}, Landroid/widget/Toast;->show()V

    :done
    return-void

    :catch_all
    return-void
.end method
