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
        Insert(true);

    end;
}