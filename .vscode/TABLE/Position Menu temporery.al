table 50131 "Position Menu temporary"
{
    Caption = 'Position';
    DrillDownPageID = "Position menu temp";
    LookupPageID = "Position menu temp";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            begin
                /*Position.INIT;
                Position.Code:=Code;
                Position.Description:=Description;
                Position."Org. Structure":="Org. Structure";
                Position.INSERT;*/
                /*OsPreparation.RESET;
                OsPreparation.SETFILTER(Status,'%1',2);
                IF OsPreparation.FINDLAST THEN BEGIN
                "Org. Structure":=OsPreparation.Code;
                END
                ELSE BEGIN
                "Org. Structure":='';
                END;
                 FOR I:=1 TO STRLEN(Rec.Code) DO BEGIN
                   String:=Rec.Code;
                         IF String[I]='.' THEN BEGIN
                            brojac:=brojac+1;
                              IF brojac=2 THEN
                                                  SectorLength:=I;
                                                  END;
                                                     END;
                                                     SectorFind.RESET;
                                                     SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorLength));
                                                     IF SectorFind.FINDFIRST THEN BEGIN
                                                     Rec."Sector Identity":=SectorFind.Identity;
                       END;
                       */

            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(3; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = "Department temporary".Code;
        }
        field(4; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
        }
        field(50004; "No. of Working Places"; Integer)
        {
            Caption = 'No. of Working Places';
        }
        field(50005; "Sector Identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50365; "Management Level"; enum "Management Level")
        {
            Caption = 'Management Level';


            trigger OnValidate()
            begin
                /*IF (("Team Description"<>'')) THEN BEGIN
                
                       posDis.SETFILTER("Department Code",'%1',"Team Code");
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                       posDis.SETFILTER("Team Description",'%1',"Team Code");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                    VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code","Team Code");
                    VALIDATE("Disc. Department Name","Team Description");
                    END;
                    END;
                
                       posDis.RESET;
                       IF (("Team Description"='') AND ("Group Description"<>'')) THEN BEGIN
                
                       posDis.SETFILTER("Department Code",'%1',"Group Code");
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                       posDis.SETFILTER("Group Description",'%1',"Group Code");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                     VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                
                     END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code","Group Code");
                   VALIDATE("Disc. Department Name","Group Description");
                    END;
                    END;
                
                    posDis.RESET;
                        IF (("Team Description"='') AND ("Group Description"='') AND  ("Department Categ.  Description"<>'')) THEN BEGIN
                       posDis.SETFILTER("Department Code",'%1',"Department Category");
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                        posDis.SETFILTER("Department Categ.  Description",'%1',"Department Categ.  Description");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                     VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code","Department Category");
                     VALIDATE("Disc. Department Code","Department Code");
                    END;
                    END;
                        IF (("Team Description"='') AND ("Group Description"='') AND  ("Department Categ.  Description"='')) THEN BEGIN
                        posDis.RESET;
                       posDis.SETFILTER("Department Code",'%1',Sector);
                       posDis.SETFILTER("Management Level",'%1',"Management Level");
                        posDis.SETFILTER("Sector  Description",'%1',"Sector  Description");
                       IF posDis.FIND('-') THEN BEGIN
                     VALIDATE("Disc. Department Code",posDis."Disc. Department Code");
                     VALIDATE("Disc. Department Name",posDis."Disc. Department Name");
                    END
                    ELSE BEGIN
                     VALIDATE("Disc. Department Code",Sector);
                    VALIDATE("Disc. Department Code","Department Code");
                    END;
                END;
                */

            end;
        }
        field(50366; "Control Function"; Boolean)
        {
            Caption = 'Control Function';
        }
        field(50367; "Key Function"; Boolean)
        {
            Caption = 'Key Function';
        }
        field(50388; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50389; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50390; Role; Code[20])
        {
            Caption = 'Role code';
            Editable = false;
        }
        field(50391; "Role Name"; Text[100])
        {
            Caption = 'Role Description';
            TableRelation = Role.Description WHERE(Status = FILTER(A));

            trigger OnValidate()
            begin

                RoleT.RESET;
                RoleT.SETFILTER(Description, '%1', "Role Name");
                IF RoleT.FINDFIRST THEN BEGIN
                    Role := RoleT.Code;
                END
                ELSE BEGIN
                    Role := '';
                END;
            end;
        }
        field(50392; "BJF/GJF"; Option)
        {
            Caption = 'BJF/GJF';
            OptionCaption = ' ,BJF,GJF';
            OptionMembers = " ",BJF,GJF;
        }
        field(50394; "Work Group"; Text[20])
        {
        }
        field(50395; "Minimal Education Level"; Option)
        {
            Caption = 'Education level';
            OptionCaption = ' ,I Stepen četri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = " ","NSS - Niža stručna sprema ","SSS - Srednja stručna sprema","KV - Kvalificirani radnik ","VKV - Visoko kvalificirani radnik ","VS - Viša stručna sprema","VSS - Visoka stručna sprema","MR - Magistar","DR - Doktor nauka ";

            trigger OnValidate()
            begin

                /*WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Position_Insert';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldCode', 200, 1, 10, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 10, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Descriptiom', 200, 1, 100, Description);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@DepartmentCode', 200, 1, 10, "Department Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EduLevel', 200, 1, 30, "Minimal Education Level");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);*/

            end;
        }
        field(50396; "Position Menu Identity"; Integer)
        {
            AutoIncrement = true;
        }
        field(50397; "Number of benefits"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Position Benefits temporery" WHERE("Position Code" = FIELD(Code),
                                                                     "Position Name" = FIELD(Description)));
            Caption = 'Number of benefits';

        }
        field(500398; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temp for position" WHERE("Position Code" = FIELD(Code),
                                                                     "Position Description" = FIELD(Description)));
            Caption = 'Number of dimension value';

        }
        field(500399; Grade; Integer)
        {
            Caption = 'Grade';
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translation"; Text[250])
        {
            Caption = 'Official Translation';
        }
        field(500403; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department temporary".Description WHERE(Code = FIELD("Department Code"),
                                                                           "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Department Name';

        }
    }

    keys
    {
        key(Key1; "Code", Description, "Department Code", "Org. Structure")
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code")
        {
        }
    }

    trigger OnDelete()
    begin
        ECLSystematization.RESET;
        ECLSystematization.SETFILTER("Position Description", '%1', Rec.Description);
        ECLSystematization.SETFILTER("Position Code", '%1', Rec.Code);
        IF ECLSystematization.FINDSET THEN
            REPEAT


                ECLSystematization.VALIDATE("Position Description", '');
            UNTIL ECLSystematization.NEXT = 0;
        HeadOf.RESET;
        HeadOf.SETFILTER("Position Code", '%1', Rec.Code);
        HeadOf.SETFILTER("Management Level", '%1', Rec."Management Level");
        IF HeadOf.FINDFIRST THEN
            HeadOf.DELETE;
    end;

    var
        Position: Record "Position";
        RoleT: Record Role;
        ClientFileName: Text;
        ServerFileName: Text;
        FileManagment: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        OsPreparation: Record "ORG Shema";
        String: Code[50];
        I: Integer;
        brojac: Integer;
        SectorFind: Record "Sector temporary";
        PositionMenu: Record "Position Menu temporary";
        SectorLength: Integer;
        ECLSystematization: Record "ECL systematization";
        HeadOf: Record "Head Of's temporary";
}

