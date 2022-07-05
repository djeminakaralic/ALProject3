pageextension 50148 "Test" extends "Document Attachment Details"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Name)
        {
            field(Content; Content)
            {
                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                end;
            }
        }
        addafter(Name)
        {
            field("File Name"; "File Name")
            {
                ApplicationArea = all;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    FilePath: Text;
                    InFileStream: InStream;
                begin
                    if Rec."File Name" <> '' then begin
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
        // Add changes to page actions here
        addafter(Preview)
        {
            // Add changes to page actions here
            action("Import Test")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                    FilePath: Text;
                    InFileStream: InStream;
                begin
                    if UploadIntoStream('Select File..', '', '', FilePath, InFileStream) then
                        UploadFile(InFileStream, FilePath);



                end;

            }

            action("Export Test")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                    FilePath: Text;
                    InFileStream: InStream;
                begin
                    DownloadFile();


                end;
            }
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