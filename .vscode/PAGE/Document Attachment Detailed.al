pageextension 50148 "Document Attachment Details" extends "Document Attachment Details"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Name)
        {
            field(Content; Content)
            {
                Visible = false;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin


                end;
            }
        }
        modify(Name)
        {
            Visible = false;
        }
        modify("File Type")
        {
            Visible = false;
        }
        modify(User)
        {
            Visible = false;
        }
        modify("Attached Date")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field("File Name"; "File Name")
            {
                ApplicationArea = all;
                DrillDown = true;
                Editable = false;
                trigger Onvalidate()
                var
                    myInt: Integer;
                    FilePath: Text;
                    InFileStream: InStream;
                begin

                    if Rec."File Name" <> 'Odaberite Datoteka ...' then begin
                        DownloadFile();
                    end
                    else begin


                        if UploadIntoStream('Select File..', '', '', FilePath, InFileStream) then
                            UploadFile(InFileStream, FilePath);
                    end;

                end;

                trigger OnDrillDown()
                var
                    myInt: Integer;
                    FilePath: Text;
                    InFileStream: InStream;
                begin


                    if Rec."File Name" <> 'Odaberite Datoteka ...' then begin
                        DownloadFile();
                    end
                    else begin


                        if UploadIntoStream('Select File..', '', '', FilePath, InFileStream) then
                            UploadFile(InFileStream, FilePath);
                    end;

                end;
            }
        }

    }

    actions
    {
        modify(Preview)
        {
            Visible = false;
        }

    }

    var
        myInt: Integer;

    procedure UploadFile(DocumentInStream: InStream; FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        OStream: OutStream;
    begin
        Validate("File Extension", FileManagement.GetExtension(FileName));
        Validate("File Name", FileManagement.GetFileNameWithoutExtension(FileName));
        rec.Content.CreateOutStream(OStream);
        CopyStream(OStream, DocumentInStream);
        Rec.User := UserId;
        "Attached Date" := System.CurrentDateTime();
        Insert(false);

    end;

    procedure DownloadFile()
    var
        IStream: InStream;
        ExportFileName: Text;
    begin

        ExportFileName := Rec."File Name" + '.' + Rec."File Extension";
        Rec.CalcFields(Content);
        if not Content.HasValue then
            exit;
        Rec.Content.CreateInStream(IStream);
        DownloadFromStream(IStream, '', '', '', ExportFileName);

    end;

}