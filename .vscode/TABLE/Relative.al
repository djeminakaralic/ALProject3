tableextension 50147 Relative_ext extends Relative
{
    fields
    {
        // Add changes to table fields here
        field(50000; Sex; Option)
        {
            Caption = 'Sex';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50004; Relation; Option)
        {
            Caption = 'Parent';
            OptionCaption = ' ,Mother,Father,Child,Spouse,Others';
            OptionMembers = " ",Mother,Father,Child,Spouse,Others;
        }
        field(50005; Akuzativ; Text[50])
        {
        }
        field(50006; Genitiv; Text[30])
        {
        }
        field(50161; "Order"; Integer)
        {
            Caption = 'Order';
        }
    }

    var
        myInt: Integer;
}