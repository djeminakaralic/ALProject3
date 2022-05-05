table 50047 "Dimension for report"
{
    Caption = 'Dimension temporary';
    DrillDownPageID = "Dimensions for report";
    LookupPageID = "Dimensions for report";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin

                /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
               IF OrgStr.FINDFIRST THEN
                 BEGIN
                   "ORG Shema":=OrgStr.Code;
                 END;
                  "Dimension Code":='TC';



               String1:=FORMAT(Rec.Code);
                        LengthString:=STRLEN(String1);
                        Brojac:=0;
                        FOR I:=1 TO LengthString DO BEGIN
                        IF String1[I]='.'THEN BEGIN
                           Brojac:=Brojac+1;

                                               IF Brojac=2 THEN BEGIN
                                                 "Department Type":=8;
                                                 END;

                                                 IF Brojac=1 THEN BEGIN
                                                 "Department Type":=8;
                                                 END;
                                        END;
                                                    END;


               IF "Department Type"=8 THEN BEGIN
               Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec.Description;

                "Dimension Code":='TC';
               FindSector.RESET;
               FindSector.SETFILTER(Code,'%1',Rec.Code);
               IF FindSector.FINDFIRST THEN BEGIN
               "Sector  Description":=FindSector.Description;

                 END
                 ELSE BEGIN
                 "Sector  Description":='';
                 Sector:='';
                 END;
               DepartmentTempNes.RESET;
               DepartmentTempNes.SETFILTER(Code,'%1',Rec.Code);
               DepartmentTempNes.SETFILTER("Department Type",'%1',8);
               IF DepartmentTempNes.FINDFIRST THEN BEGIN
                 Code:=DepartmentTempNes.Code;
                 Description:=DepartmentTempNes.Description;
                 Sector:=DepartmentTempNes.Sector;
                 "Sector  Description":=DepartmentTempNes."Sector  Description";
                  Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+DepartmentTempNes."Sector  Description";
                  "Dimension Code":='TC';

                 END
                 ELSE BEGIN
                   Code:='';
                 Description:='';
                 Sector:='';
                 "Sector  Description":='';

                 END;

               END;
               */

            end;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                
                 {IF COMPANYNAME='SB' THEN BEGIN
                   OS.SETFILTER(Code,'%1',"ORG Shema");
                   OS.SETFILTER(Status,'%1',OS.Status::Active);
                IF OS.FINDFIRST THEN BEGIN
                WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Department_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
                comm.Parameters.Append(param);}
                param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
                comm.Parameters.Append(param);
                
                param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                comm.Parameters.Append(param);
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                END;
                END;}
                
                 Belongs:=FORMAT(Rec.Code)+' '+'-'+' '+Rec.Description;*/

            end;
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(8; Sector; Code[30])
        {
            Caption = 'Sector';
            // TableRelation = WBank."Employee No";

            trigger OnValidate()
            begin

                /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                  {IF Sector<>'' THEN BEGIN
                  "B-1Rec".RESET;
                  "B-1Rec".SETFILTER(Code,Rec.Sector);
                 //"B-1Rec".SETFILTER("Org Shema","ORG Shema");
                  IF "B-1Rec".FINDFIRST THEN
                    "Sector  Description":="B-1Rec".Description;
                  //"Sector Identity":="B-1Rec".Identity;
                  END
                  ELSE
                  "Sector  Description":='';}
                
                
                {IF COMPANYNAME='SB' THEN BEGIN
                   OS.SETFILTER(Code,'%1',"ORG Shema");
                  OS.SETFILTER(Status,'%1',OS.Status::Active);
                IF OS.FINDFIRST THEN BEGIN
                WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Department_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                comm.Parameters.Append(param);}
                {param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
                comm.Parameters.Append(param);}
                param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
                comm.Parameters.Append(param);
                
                param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions', 200, 1, 30,"Department Category");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream', 200, 1, 30,"Group Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                comm.Parameters.Append(param);
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                END;
                END;}
                
                
                IF Sector<>'' THEN BEGIN
                  IF "Department Type"="Department Type"::Sector THEN
                Belongs:=FORMAT(Rec.Sector)+' '+'-'+' '+Rec."Sector  Description";
                
                 "Dimension Code":='TC';
                FindSector.RESET;
                FindSector.SETFILTER(Code,'%1',Rec.Sector);
                IF FindSector.FINDFIRST THEN BEGIN
                "Sector  Description":=FindSector.Description;
                
                  END
                  ELSE BEGIN
                  "Sector  Description":='';
                  Sector:='';
                  END;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER(Code,'%1',Rec.Sector);
                DepartmentTempNes.SETFILTER(Description,'%1',Rec."Sector  Description");
                DepartmentTempNes.SETFILTER("Department Type",'%1',8);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                   Belongs:=FORMAT(Rec.Sector)+' '+'-'+' '+Rec."Sector  Description";
                   "Dimension Code":='TC';
                
                  END
                  ELSE BEGIN
                    Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                
                  END;
                 END;*/

            end;
        }
        field(9; "Department Category"; Code[30])
        {
            Caption = 'Department';
            Editable = true;
            //ĐK TableRelation = Table60002.Field1;

            trigger OnValidate()
            begin
                /*
                IF "Department Category"<>'' THEN BEGIN
                  "B-1WithRegions".RESET;
                  "B-1WithRegions".SETFILTER(Code,"Department Category");
                  //"B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                  IF "B-1WithRegions".FINDFIRST THEN
                    "Department Categ.  Description":="B-1WithRegions".Description;
                  "Department Type":="Department Type"::Department;
                  //"Department Idenity":="B-1WithRegions".Identity;
                
                  END
                  ELSE
                  "Department Categ.  Description":='';
                  "Department Type":="Department Type"::Department;
                
                  IF "Department Type"="Department Type"::Department THEN BEGIN
                Belongs:=FORMAT(Rec."Department Category")+' '+'-'+' '+Rec."Department Categ.  Description";
                END;
                
                
                  {IF COMPANYNAME='SB' THEN BEGIN
                     OS.SETFILTER(Code,'%1',"ORG Shema");
                    OS.SETFILTER(Status,'%1',OS.Status::Active);
                IF OS.FINDFIRST THEN BEGIN
                WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Department_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
                comm.Parameters.Append(param);}
                param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
                comm.Parameters.Append(param);
                
                param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream', 200, 1, 30,"Group Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                comm.Parameters.Append(param);
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                END;
                END;}
                */

            end;
        }
        field(10; "Group Code"; Code[30])
        {
            Caption = 'Group';
            Editable = true;
            //ĐK  TableRelation = Table60003.Field1;

            trigger OnValidate()
            begin

                /*IF COMPANYNAME='SB' THEN BEGIN
                   OS.SETFILTER(Code,'%1',"ORG Shema");
                  OS.SETFILTER(Status,'%1',OS.Status::Active);
                IF OS.FINDFIRST THEN BEGIN
                WPConnSetup.FINDFIRST();
                
                
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Department_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                {param:=comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
                comm.Parameters.Append(param);}
                param:=comm.CreateParameter('@Type', 200, 1, 30, "Department Type");
                comm.Parameters.Append(param);
                
                param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                comm.Parameters.Append(param);
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                END;
                END;*/

            end;
        }
        field(11; "Sector  Description"; Text[200])
        {
            Caption = 'Sector Description';
            Editable = true;
            //TableRelation = WBank."Bank Account No";

            trigger OnValidate()
            begin
                /*
                OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                IF "Sector  Description"<>'' THEN BEGIN
                  "B-1Rec".RESET;
                  "B-1Rec".SETFILTER(Description,'%1',"Sector  Description");
                  IF "B-1Rec".FINDFIRST THEN
                    Sector:="B-1Rec".Code;
                
                  END
                  ELSE BEGIN
                  "Sector  Description":='';
                  Sector:='';
                  END;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Sector  Description",'%1',Rec."Sector  Description");
                DepartmentTempNes.SETFILTER(Sector,'%1',Rec.Sector);
                DepartmentTempNes.SETFILTER("Department Type",'%1',8);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                   Belongs:=FORMAT(Rec.Sector)+' '+'-'+' '+Rec."Sector  Description";
                   "Dimension Code":='TC';
                
                  END
                  ELSE BEGIN
                 Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                  END;
                 */

            end;
        }
        field(12; "Department Categ.  Description"; Text[85])
        {
            Caption = 'Department (description)';
            Editable = true;
            // ĐKTableRelation = Table60002.Field50000 WHERE (Field50001=FIELD(ORG Shema));

            trigger OnValidate()
            begin
                /*
                OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                
                 IF "Department Categ.  Description"<>'' THEN BEGIN
                  "B-1WithRegions".RESET;
                  "B-1WithRegions".SETFILTER(Description,Rec."Department Categ.  Description");
                 // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                  IF "B-1WithRegions".FINDFIRST THEN
                    "Department Category":="B-1WithRegions".Code;
                
                  END
                  ELSE
                  "Department Category":='';
                
                  "Department Type":="Department Type"::Department;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Department Categ.  Description",'%1',Rec."Department Categ.  Description");
                //DepartmentTempNes.SETFILTER("Department Category",'%1',Rec."Department Category");
                DepartmentTempNes.SETFILTER("Department Type",'%1',4);
                DepartmentTempNes.SETFILTER("ORG Shema",'%1',"ORG Shema");
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                  "Group Code":=DepartmentTempNes."Group Code";
                  "Group Description":=DepartmentTempNes."Group Description";
                  "Team Code":=DepartmentTempNes."Team Code";
                  "Team Description":=DepartmentTempNes."Team Description";
                   Belongs:=FORMAT(Rec."Department Category")+' '+'-'+' '+Rec."Department Categ.  Description";
                   "Dimension Code":='TC';
                  END
                  ELSE BEGIN
                    Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                  "Group Code":='';
                  "Group Description":='';
                  "Team Code":='';
                  "Team Description":='';
                  END;
                 */

            end;
        }
        field(13; "Group Description"; Text[85])
        {
            Caption = 'Group Description';
            Editable = true;
            // ĐK TableRelation = Table60003.Field10 WHERE (Field50000=FIELD(ORG Shema));

            trigger OnValidate()
            begin
                /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                
                IF "Group Description"<>'' THEN BEGIN
                  StreamRec.RESET;
                  StreamRec.SETFILTER(Description,'%1',"Group Description");
                 // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                  IF StreamRec.FINDFIRST THEN
                    "Group Code":=StreamRec.Code;
                
                  END
                  ELSE
                  "Group Description":='';
                  "Department Type":="Department Type"::Group;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Group Description",'%1',Rec."Group Description");
                DepartmentTempNes.SETFILTER("Group Code",'%1',Rec."Group Code");
                DepartmentTempNes.SETFILTER("Department Type",'%1',2);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                  "Group Code":=Rec."Group Code";
                  "Group Description":=Rec."Group Description";
                  "Department Category":=DepartmentTempNes."Department Category";
                  "Department Categ.  Description":=DepartmentTempNes."Department Categ.  Description";
                   Belongs:=FORMAT(Rec."Group Code")+' '+'-'+' '+Rec."Group Description";
                   "Dimension Code":='TC';
                
                
                  END
                  ELSE BEGIN
                    Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                  "Group Code":='';
                  "Group Description":='';
                  END;*/

            end;
        }
        field(21; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;
        }
        field(39; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(40; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            //ĐK  Editable = false;
            TableRelation = "Dimension Value".Code WHERE(Status = CONST(A));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                /* IF "Dimension Value Code"<>''then BEGIN
                 "Dimension Code":='TC'*/
                DimensionValueTable.RESET;
                DimensionValueTable.SETFILTER(Code, '%1', Rec."Dimension Value Code");
                DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                IF DimensionValueTable.FINDFIRST THEN BEGIN
                    "Dimension  Name" := DimensionValueTable.Name;

                END
                ELSE BEGIN
                    "Dimension  Name" := '';

                END;
                VALIDATE("Dimension  Name", rec."Dimension  Name");

            end;
        }
        field(41; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = true;
            FieldClass = Normal;
            TableRelation = "Dimension Value".Name WHERE(Status = CONST(A));


            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

                DimensionValueTable.RESET;
                DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                IF DimensionValueTable.FINDFIRST THEN BEGIN
                    "Dimension Value Code" := DimensionValueTable.Code;

                END
                ELSE BEGIN
                    "Dimension Value Code" := '';

                END;

                /*  IF "Department Type"=4 THEN BEGIN
                  DepTempBelong.RESET;
                  DepTempBelong.SETFILTER(Code,'%1',Rec.Code);
                  IF DepTempBelong.FINDSET THEN REPEAT
                  IF DepTempBelong."Number of dimension value"=0 THEN BEGIN
                  DepTempBelong1:=DepTempBelong;
                  DepTempBelong1."Name of TC":=Rec."Dimension Value Code"+' '+'-'+' '+Rec."Dimension  Name";
                  DepTempBelong1.MODIFY;
                  END
                  ELSE BEGIN
                  DepTempBelong1:=DepTempBelong;
                   DepTempBelong1."Name of TC":='';
                  DepTempBelong1.MODIFY;
                  END;
                    UNTIL DepTempBelong.NEXT=0;
                    END;
                     IF "Department Type"=2 THEN BEGIN
                     GroupTempBelong.RESET;
                 GroupTempBelong.SETFILTER(Description,'%1',Rec.Description);
                  IF GroupTempBelong.FINDSET THEN REPEAT
                  IF GroupTempBelong."Number of dimension value"=0 THEN BEGIN
                  GroupTempBelong1:=GroupTempBelong;
                  GroupTempBelong1."Name of TC":=Rec."Dimension Value Code"+' '+'-'+' '+Rec."Dimension  Name";
                  GroupTempBelong1.MODIFY;
                  END
                  ELSE BEGIN
                  GroupTempBelong1:=GroupTempBelong;
                  GroupTempBelong1."Name of TC":='';
                  GroupTempBelong1.MODIFY;
                  END;
                    UNTIL GroupTempBelong.NEXT=0;
                    END;
                    IF "Department Type"=9 THEN BEGIN
                    TeamTempBelong.RESET;
                     TeamTempBelong.SETFILTER(Name,'%1',Rec.Description);
                  IF TeamTempBelong.FINDSET THEN REPEAT
                  IF TeamTempBelong."Number of dimension value"=0 THEN BEGIN
                  TeamTempBelong1:=TeamTempBelong;
                  TeamTempBelong1."Name of TC":=Rec."Dimension Value Code"+' '+'-'+' '+Rec."Dimension  Name";
                  TeamTempBelong1.MODIFY;
                  END
                  ELSE BEGIN
                   TeamTempBelong1:=TeamTempBelong;
                   TeamTempBelong1."Name of TC":='';
                  TeamTempBelong1.MODIFY;
                  END;
                    UNTIL TeamTempBelong.NEXT=0;
                    END;
                    */
                //Position Code,Dimension Value Code,ORG Shema,Position Description

            end;
        }
        field(43; "Team Code"; Code[30])
        {
            Caption = 'Team';
            // ĐK TableRelation = Table60004.Field1;
        }
        field(44; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            //ĐK   TableRelation = Table60004.Field2 WHERE (Field50000=FIELD(ORG Shema));

            trigger OnValidate()
            begin
                /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
                IF OrgStr.FINDFIRST THEN
                  BEGIN
                    "ORG Shema":=OrgStr.Code;
                  END;
                
                IF "Team Description"<>'' THEN BEGIN
                  TeamRec.RESET;
                 TeamRec.SETFILTER(Name,'%1',"Team Description");
                 // "B-1WithRegions".SETFILTER("Org Shema","ORG Shema");
                  IF TeamRec.FINDFIRST THEN
                    "Team Code":=TeamRec.Code;
                
                  END
                  ELSE
                  "Team Description":='';
                  "Department Type":="Department Type"::Team;
                DepartmentTempNes.RESET;
                DepartmentTempNes.SETFILTER("Team Description",'%1',Rec."Team Description");
                DepartmentTempNes.SETFILTER("Team Code",'%1',Rec."Team Code");
                DepartmentTempNes.SETFILTER("Department Type",'%1',9);
                IF DepartmentTempNes.FINDFIRST THEN BEGIN
                  Code:=DepartmentTempNes.Code;
                  Description:=DepartmentTempNes.Description;
                  Sector:=DepartmentTempNes.Sector;
                  "Sector  Description":=DepartmentTempNes."Sector  Description";
                  "Group Code":=DepartmentTempNes."Group Code";
                  "Group Description":=DepartmentTempNes."Group Description";
                  "Department Category":=DepartmentTempNes."Department Category";
                  "Department Categ.  Description":=DepartmentTempNes."Department Categ.  Description";
                  "Team Code":=DepartmentTempNes."Team Code";
                  "Team Description":=DepartmentTempNes."Team Description";
                   Belongs:=FORMAT(Rec."Team Code")+' '+'-'+' '+Rec."Team Description";
                   "Dimension Code":='TC';
                
                  END
                  ELSE BEGIN
                    Code:='';
                  Description:='';
                  Sector:='';
                  "Sector  Description":='';
                  "Group Code":='';
                  "Group Description":='';
                  "Team Code":='';
                  "Team Description":='';
                  END;
                  */

            end;
        }
        field(50003; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50004; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50005; Belongs; Text[200])
        {
            Caption = 'belong';

            trigger OnValidate()
            begin
                /*IF "Department Type"="Department Type"::Department
                  THEN
                  Belongs:=FORMAT(Rec."Department Category")+' '+'-'+' '+Rec."Department Categ.  Description";
                  IF "Department Type"="Department Type"::Group
                  THEN
                  Belongs:=FORMAT(Rec."Group Code")+' '+'-'+' '+Rec."Group Description";
                IF "Department Type"="Department Type"::Team
                  THEN
                  Belongs:=FORMAT(Rec."Team Code")+' '+'-'+' '+Rec."Team Description";
                  IF "Department Type"="Department Type"::Sector
                  THEN
                  Belongs:=FORMAT(Rec.Sector)+' '+'-'+' '+Rec."Sector  Description";
                  */

            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Dimension Value Code", "Team Description", "Department Categ.  Description", "Group Description", "Group Code", "ORG Shema")
        {
        }
        key(Key2; "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, Sector, "Department Category", "Group Code", "Sector  Description", "Department Categ.  Description", "Group Description", "Team Code", "Team Description")
        {
        }
    }

    trigger OnDelete()
    begin
        /*IF COMPANYNAME='SB' THEN BEGIN
               OS.SETFILTER(Code,'%1',"ORG Shema");
          OS.SETFILTER(Status,'%1',OS.Status::Active);
      IF OS.FINDFIRST THEN BEGIN
      WPConnSetup.FINDFIRST();


      CREATE(conn, TRUE, TRUE);

      conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

      CREATE(comm,TRUE, TRUE);

      lvarActiveConnection := conn;
      comm.ActiveConnection := lvarActiveConnection;

      comm.CommandText := 'dbo.Department_Delete';
      comm.CommandType := 4;
      comm.CommandTimeout := 0;

      {param:=comm.CreateParameter('@Code', 200, 1, 30, Rec.Code);
      comm.Parameters.Append(param);}

      comm.Execute;
      conn.Close;
      CLEAR(conn);
      CLEAR(comm);
      END;
      END;
      "Last Date Modified" := TODAY;
      //"Operator No.":=COPYSTR(USERID,1,15)
      Dimension.SETFILTER(Code,'%1','TC');
      IF Dimension.FINDFIRST THEN BEGIN
      "Dimension Code":=Dimension.Code;
      END
      ELSE BEGIN
      "Dimension Code":='';
      END;
      */
        Rec.DELETE;

    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);


        /*OrgStr.SETFILTER(Status,'%1',OrgStr.Status::Preparation);
        IF OrgStr.FINDFIRST THEN
          BEGIN
            "ORG Shema":=OrgStr.Code;
          END;
          IF COMPANYNAME='SB' THEN BEGIN*/


        /* OS.SETFILTER(Code,'%1',"ORG Shema");
        OS.SETFILTER(Status,'%1',OS.Status::Active);
    IF OS.FINDFIRST THEN BEGIN
    WPConnSetup.FINDFIRST();


    CREATE(conn, TRUE, TRUE);

    conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
              +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

    CREATE(comm,TRUE, TRUE);

    lvarActiveConnection := conn;
    comm.ActiveConnection := lvarActiveConnection;

    comm.CommandText := 'dbo.Department_Insert';
    comm.CommandType := 4;
    comm.CommandTimeout := 0;


    param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@Type', 200, 1, 30,"Department Type");
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
    comm.Parameters.Append(param);
    param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
    comm.Parameters.Append(param);
    comm.Execute;
    conn.Close;
    CLEAR(conn);
    CLEAR(comm);

    END;
    END;
    */

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        //  WPConnSetup: Record "Web portal connection setup";

        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";

        // Position: Record "Confidential Clerks";
        //Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        // Tip: Record "Type";
        OrgStr: Record "ORG Shema";
        Dimension: Record "Dimension";
        String: Text;
        Brojac: Integer;
        String1: Text;
        LengthString: Integer;
        I: Integer;
        DimensionValueTable: Record "Dimension Value";
}

