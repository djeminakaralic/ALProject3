table 50031 Error
{
    Caption = 'Error';

    fields
    {
        field(1;"No.";Integer)
        {
            Caption = 'No.';
            Description = 'Primary Key';
        }
        field(5;Description;Text[250])
        {
            Caption = 'Description';
        }
        field(6;"Table";Text[250])
        {
            Caption = 'Table';
        }
        field(10;Value;Text[250])
        {
            Caption = 'Value';
        }
        field(15;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Error,Possible Error';
            OptionMembers = "Greška","Moguća Greška";
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }
}

