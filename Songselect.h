#ifndef SONGSELECT_H
#define SONGSELECT_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QDir>
#include <QDirIterator>
#include <QJsonObject>
#include <QJsonDocument>
#include <QList>
#include <QDebug>
#include <QFile>

class Songselect : public QObject {

    Q_OBJECT
    Q_PROPERTY(QVariantList content READ readContent NOTIFY contentChanged)

public:
    Songselect () {
        reload_song_meta();
    }

    void reload_song_meta() {
        songs_path = QDir::currentPath() + "/songs/";
        QStringList content_list = QDir(songs_path).entryList(QDir::AllDirs | QDir::NoDotAndDotDot);
        //m_content = content_list.join("\n");
        QString tmp = songs_path + content_list[0] + "/meta.json";

        songs_meta.clear();
        foreach (QString path, content_list) {
            QString str = songs_path + path;
            if (!song_meta_parse(str)) {
                qDebug() << "failed on parsing " + str;
            }
        }

        m_content = songs_meta;
    }

    QVariantList readContent() {
        return m_content;
    }

signals:
    void contentChanged();

private:
    void test () {
        QJsonObject json;
        json.insert("Name", "Qt");
        json.insert("From", 1991);
        json.insert("Cross Platform", true);

        QJsonDocument document;
        document.setObject(json);
        QByteArray byteArray = document.toJson(QJsonDocument::Compact);
        QString strJson(byteArray);

        qDebug() << strJson;
    }

    bool song_meta_parse (QString& filepath) {
        QVariantList list;
        list.append(filepath);

        QFile file(filepath + "/meta.json");
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qDebug() << "Error: JSON read failed.";
            return false;
        }

        QJsonParseError jsonError;
        QJsonDocument jsonDocument = QJsonDocument::fromJson(file.readAll(), &jsonError);

        if (!jsonDocument.isNull() && (jsonError.error == QJsonParseError::NoError)) {
            if (jsonDocument.isObject()) {
                QJsonObject obj = jsonDocument.object();

                if (obj.contains("ARTIST")) {
                    QJsonValue value = obj.value("ARTIST");
                    if (value.isString()) {
                        list.append(value.toString());
                    }
                }

                if (obj.contains("TITLE")) {
                    QJsonValue value = obj.value("TITLE");
                    if (value.isString()) {
                        list.append(value.toString());
                    }
                }

                if (obj.contains("GENRE")) {
                    QJsonValue value = obj.value("GENRE");
                    if (value.isString()) {
                        list.append(value.toString());
                    }
                }

                if (obj.contains("PREVIEW")) {
                    QJsonValue value = obj.value("PREVIEW");
                    if (value.isDouble()) {
                        list.append(value.toVariant().toInt());
                    }
                }

                if (obj.contains("COLOR")) {
                    QJsonValue value = obj.value("COLOR");
                    if (value.isString()) {
                        list.append(value.toString());
                    }
                }

                if (obj.contains("BASIC")) {
                    QJsonValue value = obj.value("BASIC");
                    if (value.isDouble()) {
                        list.append(value.toVariant().toInt());
                    }
                }

                if (obj.contains("EXPERT")) {
                    QJsonValue value = obj.value("EXPERT");
                    if (value.isDouble()) {
                        list.append(value.toVariant().toInt());
                    }
                }
            }
        }

        if (list.size()!=8)
            return false;

        songs_meta.insert(0, list);
        return true;
    }

    QVariantList m_content;
    QString songs_path = "";
    QVariantList songs_meta;
};

#endif // SONGSELECT_H
