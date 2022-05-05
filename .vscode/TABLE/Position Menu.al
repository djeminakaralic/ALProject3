table 50132 "Position Menu"
{
    Caption = 'Position';
    DrillDownPageID = "Position";
    LookupPageID = "Position";

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
            TableRelation = Department.Code WHERE("ORG Shema" = FIELD("Org. Structure"));
        }
        field(4; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
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
        field(50365; "Management Level"; Option)
        {
            Caption = 'Management Level';
            OptionCaption = ' ,B,B1,B2,B3,B4,CEO,E,Exe';
            OptionMembers = " ",B,B1,B2,B3,B4,CEO,E,Exe;

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
        field(50370; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = Sector.Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50371; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                ;

            end;
        }
        field(50372; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description;

            trigger OnValidate()
            begin
                /* IF (("Team Code"='') AND ("Group Code"='') AND ("Department Category"='') ) THEN BEGIN
                   Department.RESET;
                 Department.SETFILTER ("Sector  Description",'%1',Rec."Sector  Description");
                 Department.SETFILTER("ORG Shema",'%1',Rec."Org. Structure");
                 Department.SETFILTER("Department Type",'%1',8);
                
                     IF Department.FINDFIRST THEN BEGIN
                
                       "Sector  Description":=Department."Sector  Description";
                        IF "Sector  Description"<>'' THEN BEGIN
                
                          VALIDATE("Department Code",Department.Sector);
                
                          VALIDATE(Sector,Department.Sector);
                
                          END;
                  END;
                  END;
                  IF (("Team Code"='') AND ("Group Code"='') AND ("Department Category"='') AND ("Sector  Description"='')) THEN BEGIN
                    Sector:='';
                "Department Category":='';
                "Group Code":='';
                "Team Code":='';
                "Sector  Description":='';
                "Department Categ.  Description":='';
                "Group Description":='';
                "Team Description":='';
                
                  END;
                   SectorR.SETFILTER(Description,'%1',"Sector  Description");
                  IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity":=SectorR.Identity;
                    END;
                 DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                  IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity":=DepartmentC.Identity;
                
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
                PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                  IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                  PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
                END;
                */

            end;
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description;

            trigger OnValidate()
            begin
                /*IF (("Team Code"='') AND ("Group Code"='')) THEN BEGIN
                 Department.SETFILTER ("Department Categ.  Description",'%1',"Department Categ.  Description");
                     IF Department.FIND('-') THEN BEGIN
                
                
                        IF "Department Categ.  Description"<>'' THEN BEGIN
                
                          VALIDATE("Department Code",Department."Department Category");
                          VALIDATE("Department Category",Department."Department Category");
                
                          VALIDATE(Sector,Department.Sector);
                          VALIDATE("Sector  Description",Department."Sector  Description");
                          END;
                  END;
                  END;
                  IF (("Team Code"='') AND ("Group Code"='') AND ( "Department Categ.  Description"='')) THEN BEGIN
                    Sector:='';
                "Department Category":='';
                "Group Code":='';
                "Team Code":='';
                "Sector  Description":='';
                "Department Categ.  Description":='';
                "Group Description":='';
                "Team Description":='';
                END;
                
                   SectorR.SETFILTER(Description,'%1',"Sector  Description");
                  IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity":=SectorR.Identity;
                    END;
                 DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                  IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity":=DepartmentC.Identity;
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
                    "Disc. Department Code":="Department Category";
                    "Disc. Department Name":=posDis."Disc. Department Name";
                    PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                  IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                  PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
                END;
                */

            end;
        }
        field(50375; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = Group.Description WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                /*IF "Team Code"='' THEN BEGIN
                 Department.SETFILTER ("Group Description",'%1',"Group Description");
                     IF Department.FIND('-') THEN BEGIN
                
                
                        IF "Group Description"<>'' THEN BEGIN
                
                          VALIDATE("Department Code",Department."Group Code");
                          VALIDATE("Group Code",Department."Group Code");
                          VALIDATE("Department Category",Department."Department Category");
                          VALIDATE("Department Categ.  Description",Department."Department Categ.  Description");
                          VALIDATE(Sector,Department.Sector);
                          VALIDATE("Sector  Description",Department."Sector  Description");
                          END;
                  END;
                  END;
                  IF ("Team Description"='') AND ("Group Description"='') THEN BEGIN
                    Sector:='';
                "Department Category":='';
                "Group Code":='';
                "Team Code":='';
                "Sector  Description":='';
                "Department Categ.  Description":='';
                "Group Description":='';
                "Team Description":='';
                END;
                   SectorR.SETFILTER(Description,'%1',"Sector  Description");
                  IF SectorR.FINDFIRST THEN BEGIN
                    "Sector Identity":=SectorR.Identity;
                    END;
                 DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                  IF DepartmentC.FINDFIRST THEN BEGIN
                    "Department Category Identity":=DepartmentC.Identity;
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
                    PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
                PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
                PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
                IF PosMenuNew.FIND('-') THEN BEGIN
                  IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                  PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
                END;*/

            end;
        }
        field(50376; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = TeamT."Code" WHERE("Org Shema" = FIELD("Org. Structure"));
        }
        field(50377; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = TeamT.Name WHERE("Org Shema" = FIELD("Org. Structure"));

            trigger OnValidate()
            begin
                /*Department.SETFILTER ("Team Description",'%1',"Team Description");
                    IF Department.FIND('-') THEN BEGIN

                      "Team Description":=Department."Team Description";
                       IF "Team Description"<>'' THEN BEGIN
                         VALIDATE("Team Code",Department."Team Code");
                         VALIDATE("Department Code",Department."Team Code");
                         VALIDATE("Group Code",Department."Group Code");
                         VALIDATE("Group Description",Department."Group Description");
                         VALIDATE("Department Category",Department."Department Category");
                         VALIDATE("Department Categ.  Description",Department."Department Categ.  Description");
                         VALIDATE(Sector,Department.Sector);
                         VALIDATE("Sector  Description",Department."Sector  Description");
                         END;
                 END;
                 IF "Team Description"='' THEN BEGIN
                Sector:='';
               "Department Category":='';
               "Group Code":='';
               "Team Code":='';
               "Sector  Description":='';
               "Department Categ.  Description":='';
               "Group Description":='';
               "Team Description":='';
               END;


                SectorR.SETFILTER(Description,'%1',"Sector  Description");
                 IF SectorR.FINDFIRST THEN BEGIN
                   "Sector Identity":=SectorR.Identity;
                   END;
                DepartmentC.SETFILTER(Description,'%1',"Department Categ.  Description");
                 IF DepartmentC.FINDFIRST THEN BEGIN
                   "Department Category Identity":=DepartmentC.Identity;
                   END;
                     IF (("Team Description"<>'')) THEN BEGIN

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
                   PosMenuNew.SETFILTER(Code,'%1',Rec.Code);
               PosMenuNew.SETFILTER("Org. Structure",'%1',Rec."Org. Structure");
               PosMenuNew.SETFILTER(Description,'%1',Rec.Description);
               IF PosMenuNew.FIND('-') THEN BEGIN
                 IF PosMenuNew.GET(Code,Description,'',"Org. Structure") THEN
                 PosMenuNew.RENAME(Code,Description,"Department Code","Org. Structure") ;
               END;
               */

            end;
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
        field(50390; Role; Code[10])
        {
            Caption = 'Role code';
            Editable = false;
        }
        field(50391; "Role Name"; Text[100])
        {
            Caption = 'Role Description';
            TableRelation = Role.Description WHERE(Status = CONST(A));

            trigger OnValidate()
            begin

                Roles.RESET;
                Roles.SETFILTER(Description, '%1', "Role Name");
                Roles.SETFILTER(Status, '%1', Roles.Status::A);
                IF Roles.FINDFIRST THEN BEGIN
                    Role := Roles.Code;
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
        field(50394; "Work Group"; Text[10])
        {
        }
        field(50395; "Minimal Education Level"; Option)
        {
            Caption = 'Education level';
            OptionCaption = ' ,I Stepen četri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = Empty,NS,KV,VSS,MR,DR;

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
            CalcFormula = Count("Position Benefits" WHERE("Position Code" = FIELD("Code"),
                                                           "Position Name" = FIELD(Description),
                                                           "Org. Structure" = FIELD("Org. Structure")));
            Caption = 'Number of benefits';

        }
        field(500398; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension for position" WHERE("Position Code" = FIELD("Code"),
                                                                "Position Description" = FIELD(Description),
                                                                "ORG Shema" = FIELD("Org. Structure")));
            Caption = 'Number of dimension value';

        }
        field(500399; Grade; Integer)
        {
            Caption = 'Grade';
        }
        field(500402; "Official Translation"; Text[250])
        {
            Caption = 'Official Translation';
        }
        field(500403; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Description WHERE("ORG Shema" = FIELD("Org. Structure"),
                                                               "Code" = FIELD("Department Code")));
            Caption = 'Department Name';

        }
        field(500404; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
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

    var
        Position: Record "Position";
        RoleT: Record "Role";
        Roles: Record "Role";
}

