package com.worksb.hi.admin.web;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.worksb.hi.admin.service.AdminService;
import com.worksb.hi.common.PagingVO;
import com.worksb.hi.company.service.CompanyService;
import com.worksb.hi.company.service.CompanyVO;
import com.worksb.hi.company.service.DepartmentVO;
import com.worksb.hi.company.service.JobVO;
import com.worksb.hi.member.service.MemberService;
import com.worksb.hi.member.service.MemberVO;
import com.worksb.hi.project.service.ProjectVO;
@RequestMapping("/admin")
@Controller
public class AdminController {
	@Value("${file.upload.path}")
	private String uploadPath;
	
	@Autowired
	CompanyService companyService;
	@Autowired
	MemberService memberService;
	@Autowired
	AdminService adminService;
	
	@RequestMapping("/companyInfo")
	public String companyInfo() {
		return "admin/companyInfo";
	}
	
	
	@PostMapping("/updateCompany")
	public String updateCompany(CompanyVO companyVO, @RequestPart MultipartFile logo, HttpSession session, Model model) {
		CompanyVO dbCompany = companyService.getCompanyByUrl(companyVO);
		String message = null;
		
		if(dbCompany != null) {
			message = "이미 존재하는 회사 url 입니다. 다시 입력해 주세요.";
			model.addAttribute("message", message);
			
			return "/companyInfo";
		} 
		
		String originalName = logo.getOriginalFilename();	
		System.out.println(originalName+"originalName");
		String fileName = originalName.substring(originalName.lastIndexOf("//")+1);
		System.out.println(fileName+"fileName");
		String folderPath = makeFolder();
		System.out.println(folderPath+"folderPath");
		String uuid = UUID.randomUUID().toString();
		System.out.println(uuid+"uuid");
		String uploadFileName = folderPath + File.separator + uuid + "_" + fileName;
		System.out.println(uploadFileName+"uploadFileName");
		String saveName = uploadPath + File.separator + uploadFileName;
		System.out.println(saveName+"saveName");
		Path savePath = Paths.get(saveName);
		System.out.println(savePath+"savePath");
		
		try {
			logo.transferTo(savePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		companyVO.setLogoPath(fileName);
		companyVO.setRealLogoPath(setImagePath(uploadFileName));
		
		companyService.insertCompany(companyVO);
		
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		member.setCompanyId(companyVO.getCompanyId());
		member.setCompanyAccp("A1");
		member.setMemberGrade("H1");
		
		memberService.updateMember(member);
		
		session.setAttribute("companyId", member.getCompanyId());
		
		return "/companyInfo";
	}
	//폴더생성
		public String makeFolder() {
			String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
			
			String folderPath = str.replace("/", File.separator);
			File uploadPathFolder = new File(uploadPath, folderPath);
			
			if(uploadPathFolder.exists() == false) {
				uploadPathFolder.mkdirs();
			}
			
			return folderPath;
		}
		public String setImagePath(String uploadFileName) {
			return uploadFileName.replace(File.separator, "/");
		}
		

		@RequestMapping("/downloadlist")
		public String downloaded(Model m,HttpSession session,
				@RequestParam(value="nowPage", defaultValue ="1") Integer nowPage,
				@RequestParam(value="cntPerPage", defaultValue ="10") Integer cntPerPage) {
			Integer companyId=((CompanyVO)session.getAttribute("companyInfo")).getCompanyId();
			int total=adminService.downloadCount(companyId);
			PagingVO pagingvo=new PagingVO(total,nowPage,cntPerPage);
			
			m.addAttribute("list",adminService.downloadList(companyId,pagingvo));
			m.addAttribute("paging", pagingvo);
			return "admin/downloadedfile";
		}
		
		@GetMapping("/projectlist")
		public String prjList(Model m,HttpSession session,
				@RequestParam(value="nowPage", defaultValue ="1") Integer nowPage,
				@RequestParam(value="cntPerPage", defaultValue ="10") Integer cntPerPage) {
			Integer companyId=((CompanyVO)session.getAttribute("companyInfo")).getCompanyId();
			int total=adminService.prjcount(companyId);
			PagingVO pagingvo=new PagingVO(total,nowPage,cntPerPage);
			List<ProjectVO> list=adminService.projectList(companyId, pagingvo);
			m.addAttribute("paging", pagingvo);
			m.addAttribute("list",list);
			return "admin/projectList";
		}
		
		
		@GetMapping("/editRole")
		public String editRole(Model m,HttpSession session) {
			Integer companyId=((CompanyVO)session.getAttribute("companyInfo")).getCompanyId();
			m.addAttribute("dlist",adminService.departmentList(companyId));
			m.addAttribute("jList",adminService.jobList(companyId));
			return "admin/editRole";
		}
		
		@PostMapping("/insertDept")
		@ResponseBody
		public int updateDept(HttpSession session,@RequestParam("deptName")String deptName,DepartmentVO vo) {
			Integer companyId=((CompanyVO)session.getAttribute("companyInfo")).getCompanyId();
			vo.setCompanyId(companyId);
			vo.setDeptName(deptName);
			return adminService.insertDept(vo);
		}
		
		@PostMapping("/deleteDept")
		@ResponseBody
		public int deleteDept(HttpSession session,@RequestParam("deptId")int deptId) {
			return adminService.deleteDept(deptId);
		}
		
		@PostMapping("/insertRole")
		@ResponseBody
		public int updateRole(HttpSession session,@RequestParam("roleName")String roleName,JobVO vo) {
			Integer companyId=((CompanyVO)session.getAttribute("companyInfo")).getCompanyId();
			vo.setCompanyId(companyId);
			vo.setJobName(roleName);
			return adminService.insertRole(vo);
		}
		
		@PostMapping("/deleteRole")
		@ResponseBody
		public int deleteRole(HttpSession session,@RequestParam("roleId")int jobId) {
			return adminService.deleteRole(jobId);
		}
		
		// 회사 정보 수정폼
		@GetMapping("/company/companyInfoForm")
		public String companyInfoForm(Model model, HttpSession session) {
			CompanyVO company = (CompanyVO)session.getAttribute("companyInfo");
			model.addAttribute("companyInfo", company);
			return "adminPage/companyInfo";
		}
		
		// 회사 정보 수정
		@RequestMapping("company/updateCompany")
		@ResponseBody
		public boolean updateCompany(CompanyVO companyVO, HttpSession session) {
			
			int result = adminService.updateCompany(companyVO);
			if(result == 0) {
				return false;
			}
			
			CompanyVO updatedCompany = companyService.getCompanyById(companyVO);
			session.setAttribute("companyInfo", updatedCompany);
			return true;
		}
		
		// 회사 구성원 리스트
		@RequestMapping("/memberManagement")
		public String CompanyMemberList(Model model, HttpSession session, MemberVO memberVO) {
			CompanyVO company = (CompanyVO)session.getAttribute("companyInfo");
			Integer companyId = company.getCompanyId();
			// list넘기기
			List<MemberVO> memberList = adminService.companyMemberList(companyId);
			model.addAttribute("memberList", memberList );
			return "adminPage/memberManagement";
		}
		
		// 구성원 정보 단건조회
		@RequestMapping("/memberManagements")
		@ResponseBody
		public MemberVO CompanyMemberInfo(MemberVO memberVO) {
			return adminService.companyMemberInfo(memberVO);
		}
		
		// 구성원 정보 수정
		@RequestMapping("/memberAdminUpdate")
		@ResponseBody
		public String updateMember(MemberVO memberVO) {
			return adminService.updateMember(memberVO);
		}

		@PostMapping("/updateRole")
		@ResponseBody
		public int updateRole(@RequestParam("roleId")int jobId,@RequestParam("roleName") String jobName) {
			JobVO vo=new JobVO();
			vo.setJobId(jobId);
			vo.setJobName(jobName);
			return adminService.updateRole(vo);
		}
		
		@PostMapping("/updateDept")
		@ResponseBody
		public int updateDept(@RequestParam("deptId")int deptId,@RequestParam("deptName") String deptName) {
			DepartmentVO vo=new DepartmentVO();
			vo.setDeptId(deptId);
			vo.setDeptName(deptName);
			
			List<String> names=new ArrayList<>();
			
			List<ProjectVO> prjName=adminService.getPrjName(deptId);
			List<ProjectVO> prjIdx=adminService.getPrjId(deptId);
			for(ProjectVO name:prjName) {
				String deptNameAndPrjName=name.getProjectName();
				String nameList[]=deptNameAndPrjName.split("]");
				names.add(nameList[1]);
			}
			for(int i=0;i<names.size();i++) {
				names.set(i, "["+deptName+"]"+names.get(i));
				System.out.println("수정한이름"+names.get(i));
			}
			//adminservice.updateprojectName(names,deptId);
			//return adminservice.updateDept(vo);
			return 0;
		}
}
