table 50027 "Tax Class"
{
    Caption = 'Tax Class';

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
        }
        field(5;Percentage;Decimal)
        {
            Caption = 'Percentage';
        }
        field(10;"Valid From Amount";Decimal)
        {
            Caption = 'Valid From Amount';
        }
        field(15;"Valid To Amount";Decimal)
        {
            Caption = 'Valid To Amount';
        }
        field(20;Active;Boolean)
        {
            Caption = 'Active';
        }
        field(30;"Entity Code";Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
        key(Key2;"Valid From Amount")
        {
        }
    }

    fieldgroups
    {
    }
}

