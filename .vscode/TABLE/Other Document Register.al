table 50116 "Other Document Register"
{
    Caption = 'Other Document Register';
    DrillDownPageID = "Other Document Register";
    LookupPageID = "Other Document Register";

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(2; "Agreement Code"; Code[30])
        {
            Caption = 'Agreement code';
        }
        field(3; Group; Text[188])
        {
            Caption = 'Group';
        }
        field(4; "Document Description"; Text[250])
        {
            Caption = 'Document description';
        }
        field(5; "NAV Agreement Code"; Integer)
        {
            Caption = 'Agreement code';
        }
        field(6; "Attachment No cert"; Integer)
        {
        }
        field(7; "Show Template"; Boolean)
        {
            Caption = 'Show Template';
        }
    }

    keys
    {
        key(Key1; ID, "Document Description")
        {
        }
        key(Key2; "Document Description")
        {
        }
        key(Key3; Group)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document Description", Group, "Agreement Code")
        {
        }
    }

    var
    //ĐK   Contract88: Report "Template 1";
    /*Contract87: Report "87";
    Contract115: Report "115";
    Contract129: Report "129";
    Contract187: Report "187";
    Contract188: Report "188";
    Contract189: Report "189";
    Contract190: Report "190";
    Contract191: Report "191";
    Contract192: Report "192";
    Contract193: Report "193";
    Contract215: Report "215";
    Contract216: Report "216";
    Contract291: Report "291";
    Contract292: Report "292";
    Contract296: Report "296";
    Contract297: Report "297";
    Contract319: Report "319";
    Contract322: Report "322";
    Contract324: Report "324";
    Contract406: Report "406";
    Contract407: Report "407";
    Contract408: Report "408";
    Contract410: Report "410";
    Contract412: Report "412";
    Contract415: Report "415";
    Contract416: Report "416";
    Contract417: Report "417";
    Contract418: Report "418";
    Contract491: Report "491";
    Contract496: Report "496";
    Contract497: Report "497";
    Contract498: Report "498";
    Contract499: Report "499";
    Contract298: Report "298";*/
}

