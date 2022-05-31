table 50040 "Department Category"
{
    Caption = 'Department';
    DrillDownPageID = "Department Category";
    LookupPageID = "Department Category";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
                //EVALUATE(Order,Code);
                /*Dep.SETFILTER(Code,'%1',xRec.Code);
                Dep.SETFILTER("ORG Shema",'%1',"Org Shema");
                IF Dep.FINDSET THEN REPEAT
                  IF Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description")
                    THEN
                    Dep.RENAME(Rec.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description")
                      UNTIL Dep.NEXT=0;
                      */
                "Department Type" := "Department Type"::Department;
                Dep.RESET;
                Dep.SETFILTER(Code, '%1', COPYSTR(Code, 1, 4));
                IF Dep.FINDFIRST THEN BEGIN
                    "Identity Sector" := Dep."Sector Identity";
                END;

            end;
        }
        field(2; Day; Option)
        {
            Caption = 'Day';
            OptionCaption = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(3; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            NotBlank = true;
        }
        field(4; "Starting Time"; Time)
        {
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                /*IF ("Ending Time" = 0T) OR
                   ("Ending Time" < "Starting Time")
                THEN BEGIN
                  ShopCalendar.SETRANGE(Code,Code);
                  ShopCalendar.SETRANGE(Day,Day);
                  ShopCalendar.SETRANGE("Starting Time","Starting Time",235959T);
                  IF ShopCalendar.FINDFIRST THEN
                    "Ending Time" := ShopCalendar."Starting Time"
                  ELSE
                    "Ending Time" := 235959T;
                END;
                CheckRedundancy;
                */

            end;
        }
        field(5; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                /*IF ("Ending Time" < "Starting Time") AND
                   ("Ending Time" <> 000000T)
                THEN
                  ERROR(Text000,FIELDCAPTION("Ending Time"),FIELDCAPTION("Starting Time"));
                
                CheckRedundancy;
                */

            end;
        }
        field(12; n; Option)
        {
            OptionMembers = ,Percentage,First,Last,"First 1","First 2";
        }
        field(50000; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                /*Dep.SETFILTER(Code,'%1',Rec.Code);
                Dep.SETFILTER("ORG Shema",'%1',"Org Shema");
                
                IF Dep.FINDSET THEN REPEAT
                  IF Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description",xRec.Description)
                    THEN BEGIN
                    Dep.RENAME(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description",Rec.Description) ;
                     // Dep.Description:=Rec.Description;
                     // Dep.MODIFY;
                      END;
                      UNTIL Dep.NEXT=0;*/

            end;
        }
        field(50001; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50002; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50003; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50004; "Changing Department"; Boolean)
        {
            Caption = 'Changing Department';

            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
                    END;*/

            end;
        }
        field(50005; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50006; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50007; Identity; Integer)
        {
            AutoIncrement = true;
            Caption = 'Identity';
            Editable = false;
        }
        field(50008; "Identity Sector"; Integer)
        {
        }
        field(50010; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            /*TableRelation = Table60008.Field40 WHERE(Field1 = FIELD(Code),
                                                      Field12 = FIELD(Description),
                                                      Field9 = FIELD(Code));*/

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                /*IF "Dimension Value Code" <>'' THEN BEGIN
                DimensionNew.SETFILTER("Dimension Value Code",'%1',Rec."Dimension Value Code");
                IF DimensionNew.FINDFIRST THEN BEGIN
                DimensionNew.CALCFIELDS("Dimension  Name");
                "Dimension  Name":=DimensionNew."Dimension  Name";
                END;
                END
                ELSE BEGIN
                "Dimension  Name":='';
                END;
                */

            end;
        }
        field(50011; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(50017; "Department Type"; Enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(50018; "Sector Belongs"; Text[250])
        {
            TableRelation = Sector.Description;

        }
        field(500402; "Official Translate of DepCat"; Text[250])
        {
            Caption = 'Official Translate of DepCat';
        }
        field(500403; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
        }
        field(500404; Ispis; Boolean)
        {
        }
        field(500405; Parent; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Org Shema", Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code", "Org Shema")
        {
        }
    }

    trigger OnInsert()
    begin
        //CheckRedundancy;
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("B-1 (with regions) Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."B-1 (with regions) Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        "Department Type" := "Department Type"::"Department Category";
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    trigger OnRename()
    begin
        //CheckRedundancy;
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        Text001: Label 'There is redundancy in the Shop Calendar. Actual work shift %1 from : %2 to %3. Conflicting work shift %4 from : %5 to %6.';
        ShopCalendar: Record "Department Category";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";

    local procedure CheckRedundancy()
    var
        ShopCalendar2: Record "Department Category";
        TempShopCalendar: Record "Department Category" temporary;
    begin
        /*ShopCalendar2.SETRANGE(Code,Code);
        ShopCalendar2.SETRANGE(Day,Day);
        IF ShopCalendar2.FIND('-') THEN
          REPEAT
            TempShopCalendar := ShopCalendar2;
            TempShopCalendar.INSERT;
          UNTIL ShopCalendar2.NEXT = 0;
        
        TempShopCalendar := xRec;
        IF TempShopCalendar.DELETE THEN ;
        
        TempShopCalendar.SETRANGE(Code,Code);
        TempShopCalendar.SETRANGE(Day,Day);
        TempShopCalendar.SETRANGE("Starting Time",0T,"Ending Time" - 1);
        TempShopCalendar.SETRANGE("Ending Time","Starting Time" + 1,235959T);
        
        IF TempShopCalendar.FINDFIRST THEN
          ERROR(
            Text001,
            "Work Shift Code",
            "Starting Time",
            "Ending Time",
            TempShopCalendar."Work Shift Code",
            TempShopCalendar."Starting Time",
            TempShopCalendar."Ending Time");
        */

    end;
}

